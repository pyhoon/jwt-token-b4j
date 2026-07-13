B4J=true
Group=Classes
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
'Based on: https://github.com/auth0/java-jwt
'Additional Libraries: JavaObject, jStringUtils
Sub Class_Globals
	Private SU 				As StringUtils
	Private ALG 			As JavaObject
	Private JWT 			As JavaObject
	Private builder 		As JavaObject
	Private verifier 		As JavaObject
	Private decoded 		As JavaObject
	Private m_Issuer 		As String
	Private m_Claims 		As Map
	Private m_Token 		As Object
	Private m_Initialized 	As Boolean
	Private m_Verified 		As Boolean
	Private m_Exception 	As String
End Sub

Public Sub Initialize (Algorithm As String, Secret As String, Base64Encode As Boolean)
	Dim SupportedAlgorithms As List = Array As String("HMAC256", "HMAC384", "HMAC512", "RSA256", "RSA384", "RSA512")
	If SupportedAlgorithms.IndexOf(Algorithm) > -1 Then
		Algorithm = Algorithm.ToUpperCase
	Else
		m_Exception = "Algorithm not supported"
		Return
	End If
	If Base64Encode Then
		Secret = SU.EncodeBase64(Secret.GetBytes("UTF8"))
	End If
	Dim AO As JavaObject
	AO.InitializeStatic("com.auth0.jwt.algorithms.Algorithm")
	ALG = AO.RunMethod(Algorithm, Array As String(Secret))
	JWT.InitializeStatic("com.auth0.jwt.JWT")
	builder = JWT.RunMethodJO("create", Null)
	verifier = JWT.RunMethodJO("require", Array(ALG)).RunMethodJO("build", Null)
	m_Initialized = True
End Sub

Public Sub IsInitialized As Boolean
	Return m_Initialized
End Sub

Public Sub getIssuer As String
	Dim iss As String
	Try
		If m_Verified Then
			iss = decoded.RunMethod("getIssuer", Null)
		End If
		m_Issuer = iss
	Catch
		m_Exception = LastException.Message
		'Log(m_Exception)
	End Try
	Return m_Issuer
End Sub

Public Sub setIssuer (Issuer As String)
	Try
		builder.RunMethodJO("withIssuer", Array(Issuer))
	Catch
		m_Exception = LastException.Message
		'Log(m_Exception)
	End Try
	m_Issuer = Issuer
End Sub

Public Sub getClaims As Map
	Dim clm As Map
	Try
		If m_Verified Then
			clm = decoded.RunMethod("getClaims", Null)
		End If
		m_Claims = clm
	Catch
		m_Exception = LastException.Message
		'Log(m_Exception)
	End Try
	Return m_Claims
End Sub

Public Sub setClaims (Claims As Map)
	For Each Key In Claims.Keys
		builder.RunMethodJO("withClaim", Array(Key, Claims.Get(Key)))
	Next
	m_Claims = Claims
End Sub

Public Sub ReadClaim (Key As String) As Object
	Return getClaims.Get(Key)
End Sub

Public Sub getNotBefore As Object
	Return ReadClaim("nbf")
End Sub

Public Sub getExpiresAt As Object
	Try
		If m_Verified Then
			Dim exp As Object = decoded.RunMethod("getExpiresAt", Null)
		End If
	Catch
		m_Exception = LastException.Message
		'Log(m_Exception)
	End Try
	Return exp
End Sub

Public Sub setIssuedAt (IssuedAt As Object)
	Dim jo As JavaObject = Me
	Dim dt As Object = jo.InitializeNewInstance("java.util.Date", Array(IssuedAt))
	builder.RunMethodJO("withIssuedAt", Array(dt))
End Sub

Public Sub setExpiresAt (ExpiresAt As Object)
	Dim jo As JavaObject = Me
	Dim dt As Object = jo.InitializeNewInstance("java.util.Date", Array(ExpiresAt))
	builder.RunMethodJO("withExpiresAt", Array(dt))
End Sub

Public Sub getToken As String
	Return m_Token
End Sub

Public Sub setToken (Token As String)
	m_Token = Token
End Sub

Public Sub Verify As JavaObject
	Try
		decoded = verifier.RunMethod("verify", Array(m_Token))
		m_Verified = True
	Catch
		m_Exception = LastException.Message
		m_Verified = False
	End Try
	Return decoded
End Sub

Public Sub getVerified As Boolean
	Return m_Verified
End Sub

Public Sub getError As String
	Return m_Exception
End Sub

Public Sub Sign
	m_Token = builder.RunMethodJO("sign", Array(ALG))
End Sub