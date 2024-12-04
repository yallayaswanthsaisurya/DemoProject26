resource "azurerm_resource_group" "rg" {
    name = var.resource_group
    location = var.location
  
}

  
resource "azurerm_virtual_network" "vnet" {
    name = var.vnet_name
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    address_space = var.address_space

    depends_on = [ azurerm_resource_group.rg ]
  
}


resource "azurerm_subnet" "subnet" {
 name = var.subnet_name
 virtual_network_name = azurerm_virtual_network.vnet.name
 resource_group_name = azurerm_resource_group.rg.name
address_prefixes = var.subnet_prefix
}
resource "azurerm_network_security_group" "example" {
  name                = "nsgdemo"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name


security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "random_id" "unique" {
  byte_length = 4
}

resource "azurerm_storage_account" "sg" {
  name                     = "storagedemo${random_id.unique.hex}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_network_interface" "interface" {
  name                = "interface-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [azurerm_virtual_network.vnet]
}

resource "azurerm_windows_virtual_machine" "demovirtual" {
  name                = "example-machine"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_F2"
  admin_username      = "yallayaswanth"
  admin_password      = "vm@12345678"
  network_interface_ids = [
    azurerm_network_interface.interface.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  depends_on = [azurerm_network_interface.interface  ]
}




