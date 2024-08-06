// import { config } from 'dotenv';
import * as msal from "@azure/msal-browser";
import { ConfigService } from './'
export default class AuthB2CService {
    initializeMsalAgent = async () => {
        this.msalAgent = new msal.PublicClientApplication(this.applicationConfig);
        
        // Needs to be initialized first
        await this.msalAgent.initialize();

        // this.msalAgent = new PublicClientApplication(this.applicationConfig);
        const response = await this.msalAgent.handleRedirectPromise();
        
        if(!response || !response.accessToken) {
            await this.login();
        }
    }

    constructor() {
        this.applicationConfig = {
            auth: {
                clientId: ConfigService._B2cClientId,
                authority: ConfigService._B2cAuthority,
                validateAuthority: false,
                redirectUri: `${window.location.origin}/authcallback`
            },
            cache:{
                cacheLocation: "sessionStorage",
                storeAuthStateInCookie: false
            }
        }
        this.initializeMsalAgent();
    }

    login = async () => {
        await this.msalAgent.clearCache();
        let responseUser;
        await this.msalAgent.loginPopup(
            {
                scopes: ConfigService._B2cScopes,
                prompt: 'select_account'
            }
        ).then(response => {
            responseUser = response.account;
        }).catch((err) => {
            console.log('err',err)
        });
        return (responseUser) ? responseUser : null;
        // this.msalAgent.loginRedirect({scopes:ConfigService._B2cScopes});
        // this.msalAgent.handleRedirectPromise((response) => {
        //     console.log(response)
        // });
    }

    logout = async () => await this.msalAgent.logoutRedirect()

    getToken = async () => {
        return await this.msalAgent.acquireTokenSilent({ scopes: [ConfigService._B2cScopes], authority: ConfigService._B2cAuthority })
            .then(accessToken => accessToken.accessToken);
    };
}