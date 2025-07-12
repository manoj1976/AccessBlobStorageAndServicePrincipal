codeunit 80002 StorageServiceAuthorization implements "Storage Service Authorization"
{
    var
        Token: SecretText;
        ClientId: Text;
        ClientSecret: SecretText;
        AuthURL: Text;
        RedirectUrl: Text;
        ResourceUrl: Text;
        TokenNotAcquiredErr: label 'Failed to acquire token';

    procedure Authorize(var HttpRequest: HttpRequestMessage; StorageAccount: Text)
    var
        Headers: HttpHeaders;
        AuthToken: SecretText;
    begin
        //if Token.IsEmpty() then
            Token := GetToken(ClientId, ClientSecret, AuthURL, RedirectUrl, ResourceUrl);
        HttpRequest.GetHeaders(Headers);
        if Headers.Contains('Authorization') then
            Headers.Remove('Authorization');
        AuthToken := SecretStrSubstNo('Bearer %1', Token);
        Headers.Add('Authorization', AuthToken);
    end;

    procedure SetPrincipalData(_ClientId: Text; _ClientSecret: Text; _AuthURL: Text; _RedirectURL: Text; _ResourceUrl: Text);
    begin
        ClientId := _ClientId;
        ClientSecret := _ClientSecret;
        AuthURL := _AuthURL;
        RedirectUrl := _RedirectURL;
        ResourceUrl := _ResourceUrl;
    end;

    local procedure GetToken(ClientId: Text; ClientSecret: SecretText; AuthURL: Text; RedirectUrl: Text; ResourceUrl: Text): SecretText
    var
        OAuth2: Codeunit OAuth2;
    begin
        //if not OAuth2.AcquireTokenWithClientCredentials(ClientId, ClientSecret, AuthURL, RedirectURL, ResourceUrl, Token) then
        //if not OAuth2.AcquireTokenWithClientCredentials(ClientId, ClientSecret, AuthURL, RedirectURL, ResourceUrl, Token) then
        if not OAuth2.AcquireTokenWithClientCredentials(ClientId,ClientSecret,AuthURL,RedirectUrl, ResourceUrl, Token) then
            Error(TokenNotAcquiredErr);
        exit(Token);
    end;

}
