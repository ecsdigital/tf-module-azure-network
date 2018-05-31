# More info please refer to: https://www.inspec.io/docs/

# Get path to terraform state file from attribute of kitchen-terraform.
terraform_state = attribute "terraform_state", {}

# Define how critical this control is.
control "vnet" do
  # Define how critical this control is.
  impact 0.6
  # The actual test case.
  describe "The Azure Virtual Network" do

    subject do "azurerm_virtual_network" end

    # Validate the terraform version number field.
    it "is valid" do is_expected.to match "azurerm_virtual_network" end
  end
end
