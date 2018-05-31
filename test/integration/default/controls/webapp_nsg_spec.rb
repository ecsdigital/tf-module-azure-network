# More info please refer to: https://www.inspec.io/docs/

# Get path to terraform state file from attribute of kitchen-terraform.
terraform_state = attribute "terraform_state", {}

# Define how critical this control is.
control "webapp_nsg" do
  # Define how critical this control is.
  impact 0.6
  # The actual test case.
  describe "The Azure Network Security Group" do

    subject do "azurerm_network_security_group" end

    # Validate the terraform version number field.
    it "is valid" do is_expected.to match "azurerm_network_security_group" end
  end
end
