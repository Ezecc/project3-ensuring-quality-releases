resource "azurerm_network_interface" "test" {
  name                = "${var.application_type}-${var.resource_type}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.public_ip}"
  }
}

resource "azurerm_linux_virtual_machine" "" {
  name                = "${var.application_type}-${var.resource_type}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  size                = "Standard_B1s"
  admin_username      = "chijioke"
  network_interface_ids = [azurerm_network_interface.test.id,]
  admin_ssh_key {
    username   = "chijioke"
    #public_key = "file("~/.ssh/az_eqr_id_rsa.pub")"
    public_key = ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDKQEu0jaYieuLRzCzhVyB7bYuvXvZVkKXf2qz0BSwv7QUmaA2F5KTRbG1wN5E8X7jdk/1D8s1YMp7wUKbGUZSM79WGOITMlcT2LfSSSFodrA3OuXCnLs1KIAN4+6k/urF/IiJYTuRWyGiBrtqQMvV02cuyyzSocyvbSZOJ+uGCj5RLE62VaqByyrcsW7bGTcqjB6XOx6FLPO1XyqgaZTkrtZlA5dPkaEsrPMYfl5T1INXcRcLn9bUnfIjVdu7itAyjscCOQANnFgQom3IvpP8xmD/7VEfFFA9qNEbmb6kt4IFwF5N2AeEu912L6R4qCy/BTH6bH3N3PSE+iD13LsEyDcsxTKdldaSxYsPFB03estbgom1LUTfUzbxm/gKEd8wOvLuImXGiSMB8U3uBguK9rqfmGOTBjmpeuyNi6Ud4dpkBRkzQODBK5F1Bqgx3pZM3+ZIo+yZypoTAufCvM5DXmIVMZePV39nTRLCaybsgUXxs8xQWjZ75c2v8a4mQL4aaGiPEqGj+7mv+DyT5aKTIiYKfYFYK418lRPzXUKrdXm6CKXX0yIXMYl3eXMu63g5eqL7QS5MmBoxc7WDH/wgd3kG2ar28V0P7v4fcwMZ1R6WluJao1Imkloz/Ksx50a9gXN+3ZD4X117/X79VsXoTDJaSJ4h3Nc5SbX+T/Kp3fw== cez@laptop-acs036
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
