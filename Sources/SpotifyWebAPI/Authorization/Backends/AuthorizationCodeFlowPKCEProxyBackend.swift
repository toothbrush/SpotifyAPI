import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

import Logging

#if canImport(Combine)
import Combine
#else
import OpenCombine
import OpenCombineDispatch
import OpenCombineFoundation
#endif

public struct AuthorizationCodeFlowPKCEProxyBackend: AuthorizationCodeFlowPKCEBackend {

    /// The logger for this struct.
    public static var logger = Logger(
        label: "AuthorizationCodeFlowProxyBackend", level: .critical
    )
    
    /// The client id for your application.
    public let clientId: String

    public let tokenURL: URL
    public let tokenRefreshURL: URL

    public init(clientId: String, tokenURL: URL, tokenRefreshURL: URL) {
        self.clientId = clientId
        self.tokenURL = tokenURL
        self.tokenRefreshURL = tokenRefreshURL
    }

    public func makePKCETokensRequest(
        code: String,
        codeVerifier: String,
        redirectURIWithQuery: URL
    ) -> AnyPublisher<(data: Data, response: HTTPURLResponse), Error> {
        
        let body = RemotePKCETokensRequest(
            code: code,
            codeVerifier: codeVerifier
        )
        .formURLEncoded()

        let bodyString = String(data: body, encoding: .utf8) ?? "nil"
        Self.logger.trace(
            """
            POST request to "\(self.tokenURL)" \
            (URL for requesting access and refresh tokens); body:
            \(bodyString)
            """
        )

        var tokensRequest = URLRequest(url: self.tokenURL)
        tokensRequest.httpMethod = "POST"
        tokensRequest.allHTTPHeaderFields = Headers.formURLEncoded
        tokensRequest.httpBody = body

        return URLSession.defaultNetworkAdaptor(
            request: tokensRequest
        )
        
    }

    public func makePKCERefreshTokenRequest(
        refreshToken: String
    ) -> AnyPublisher<(data: Data, response: HTTPURLResponse), Error> {
        
        let body = RemotePKCERefreshAccessTokenRequest(
            refreshToken: refreshToken
        )
        .formURLEncoded()
                
        let bodyString = String(data: body, encoding: .utf8) ?? "nil"
        
        Self.logger.trace(
            """
            POST request to "\(self.tokenRefreshURL)" \
            (URL for refreshing access token); body:
            \(bodyString)
            """
        )

        var refreshTokensRequest = URLRequest(url: self.tokenRefreshURL)
        refreshTokensRequest.httpMethod = "POST"
        refreshTokensRequest.allHTTPHeaderFields = Headers.formURLEncoded
        refreshTokensRequest.httpBody = body

        return URLSession.defaultNetworkAdaptor(
            request: refreshTokensRequest
        )
        
    }
}