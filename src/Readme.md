## Bicep Infra Deployment

### Generating an SSH Key
This repository contains a Bicep deployment for container instances, which requires an SSH public key (`key.pub`). This README provides instructions on how to generate an SSH key on both Windows and Mac, and how to use it in your Bicep deployment.

#### Windows
1. **Open PowerShell or Command Prompt**:
    - Press `Win + X` and select "Windows PowerShell" or "Command Prompt".

2. **Generate the SSH Key**:
    - Run the following command:
      ```sh
      ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
      ```
    - You will be prompted to specify a file to save the key:
      ```
      Enter file in which to save the key (C:\Users/your_username/.ssh/id_rsa):
      ```
    - Press `Enter` to save the key to the default location or specify a custom path.

3. **Add a Passphrase (Optional)**:
    - Enter a passphrase for extra security or press `Enter` to skip.

4. **Locate the Public Key**:
    - By default, the public key will be saved to `C:\Users\your_username\.ssh\id_rsa.pub`. 
    Make sure it points to the root of the contoso-traders-chaos folder and is named `key.pub`.

#### Mac / Linux
TODO

**Ensure the Public Key is in the Correct Path**:
Place your public key `key.pub` in the correct directory relative to the Bicep files. 
It is referenced like so: `keyData: loadTextContent('../../../../key.pub')` in [`containers.bicep`](infra/bicep/resources/containers.bicep#L107).
Your public key should be placed in `contoso-traders-chaos/key.pub`.


### Deploying Bicep
Use the Azure CLI to deploy your Bicep template. Ensure you are in the directory containing your Bicep file and run:
 ```shell
 az deployment sub create --location <location> --name <unique-name> --template-file main.bicep 
 ```

### Troubleshooting

- **Invalid Path**: If you encounter an error related to the path, double-check that the relative path to your public key is correct.
- **Permission Denied**: Ensure you have the necessary permissions to read the public key file.


## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Trademarks

This project may contain trademarks or logos for projects, products, or services. Authorized use of Microsoft
trademarks or logos is subject to and must follow [Microsoft's Trademark & Brand Guidelines](https://www.microsoft.com/en-us/legal/intellectualproperty/trademarks/usage/general).
Use of Microsoft trademarks or logos in modified versions of this project must not cause confusion or imply Microsoft sponsorship.
Any use of third-party trademarks or logos are subject to those third-party's policies.