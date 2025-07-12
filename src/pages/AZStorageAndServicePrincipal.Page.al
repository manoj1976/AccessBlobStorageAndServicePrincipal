page 80000 AZStorageAndServicePrincipal
{
    Caption = 'AZStorage';
    PageType = Document;
    SourceTable = "integer";
    UsageCategory = Tasks;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(AccessBlobStoragewithServicePrincipal)
            {
                Caption = 'AccessBlobStoragewithServicePrincipal';
                ApplicationArea = All;

                trigger OnAction()
                var
                    StorageServiceAuthorization: Codeunit StorageServiceAuthorization;
                    ABSContClient: Codeunit "ABS Container Client";
                    ABSBLOBClient: Codeunit "ABS Blob Client";
                    ABSContainerContentTemp: Record "ABS Container Content" temporary;
                    ABSOperationResponse: Codeunit "ABS Operation Response";
                    vartenantid, varClientId, varClienSecret, varAuthURL, varRedirectURL, varResourceUrl : Text;
                    AzureADTenant: Codeunit "Azure AD Tenant";
                begin
                    vartenantid := '<your tenanted>';
                    varClientId := '<client id>';
                    varClienSecret := '<client secret>';
                    varAuthURL := 'https://login.microsoftonline.com/' + vartenantid + '/oauth2/authorize/';
                    varRedirectURL := '';
                    varResourceUrl := 'https://<storageaccountname>.blob.core.windows.net/';
                    StorageServiceAuthorization.SetPrincipalData(
                        varClientId,
                        varClienSecret,
                        varAuthURL,
                        varRedirectURL,
                        varResourceUrl);
                        
                    ABSBLOBClient.Initialize('<storageaccountname>', '<container name>', StorageServiceAuthorization);
                    ABSOperationResponse := ABSBlobClient.ListBlobs(ABSContainerContentTemp);
                end;
            }

        }
    }
}
