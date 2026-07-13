# jwt-token-b4j
Implement JSON Web Token (JWT) to B4J server

You can use this JSON Web Token (JWT) library in B4J Pakai Server.
This library is wrapped from Java JWT github project (https://github.com/auth0/java-jwt) by Auth0 using JavaObject and jStringUtils.
HMAC and RSA algorithms supported. If you want, you can modify the class to support other algorithms.

# Examples

## Create and Sign a Token
```
Dim secret1 As String = "secret"
jwt1.Initialize("HMAC256", secret1, False)
jwt1.Issuer("Computerise")
jwt1.Claim(CreateMap("user": "Aeric", "isAdmin": True))
jwt1.ExpiresAt(DateTime.Now + 180000)
jwt1.Sign
Log( jwt1.Token )
```

## Verify and get Claims/Payload
```
Dim secret2 As String = "secret" ' secret2 should be same as secret1 otherwise verification will failed
jwt2.Initialize("HMAC256", secret2, False)
jwt2.Token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJDb21..."

jwt2.Verify
Log( jwt2.Verified )
	
If jwt2.Verified Then
    Dim ExpiresAt As String = jwt2.ExpiresAt
    Log( ExpiresAt )
	
    Dim Claims As Object = jwt2.Claims
    Log( Claims )
	
    Dim Issuer As Object = jwt2.Issuer
    Log( Issuer )
End If
```
