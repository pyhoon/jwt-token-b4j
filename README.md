# jwt-token-b4j
Implement JSON Web Token (JWT) to B4J server

You can use this class to generate JSON Web Token (JWT) for use in Web API B4J Server.
This code is using JavaObject from Java JWT github project (https://github.com/auth0/java-jwt) by Auth0.
I only add support for HMAC algorithms. If you want, you can modify this code to support RSA and ECDSA algorithms.

# Examples

## Create and Sign a Token
```
Dim secret1 As String = "secret"
jwt1.Initialize("HMAC256", secret1, False)
jwt1.withIssuer("Computerise")
jwt1.withClaim(CreateMap("user": "Aeric", "isAdmin": True))
jwt1.withExpiresAt(DateTime.Now + 180000)
jwt1.Sign
Log( jwt1.Token )
```

## Verify and get Claims/Payload
```
Dim secret2 As String = "secret" ' secret2 should be same as secret1 otherwise verification will failed
jwt2.Initialize("HMAC256", secret2, False)
jwt2.Token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJDb21..."

jwt2.Verify
'Log( jwt2.Verified )
	
If jwt2.Verified Then
    Dim ExpDate As String = jwt2.exp
    Log( ExpDate )
	
    Dim claims As Object = jwt2.claims
    Log( claims )
	
    Dim issuer As Object = jwt2.getClaimByKey("iss")
    Log( issuer )
End If
```
