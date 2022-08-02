# jwt-token-b4j
Implement JSON Web Token (JWT) to B4J server

You can use this class to generate JSON Web Token (JWT) for use in Web API B4J Server.
This code is using JavaObject from Java JWT github project (https://github.com/auth0/java-jwt) by Auth0.
I only add support for HMAC algorithms. If you want, you can modify this code to support RSA and ECDSA algorithms.

# Examples

## Create and Sign a Token
```
jwt.withIssuer("Computerise")
jwt.withClaim(CreateMap("user": "Aeric", "isAdmin": True))
jwt.withExpiresAt(DateTime.Now + 180000)
jwt.Sign
Return jwt.Token
```

## Verify and get Claims/Payload
```
jwt.Token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJDb21..."
Dim ExpDate As String = jwt.exp
Log( ExpDate )
	
Dim claims As Object = jwt.claims
Log( claims )
	
Dim issuer As Object = jwt.getClaimByKey("iss")
Log( issuer )
```
