## Creación de una máquina virtual con Windows usando Terraform

Este repositorio contiene el código de Terraform necesario para crear una máquina virtual con sistema operativo Windows en el proveedor de nube AWS. La máquina tendrá un disco virtual de 30 GB y podrá ser accedida de forma remota mediante el protocolo RDP.

## Requisitos previos
Antes de comenzar, asegúrate de tener lo siguiente:

- Una cuenta en AWS con las credenciales adecuadas para crear recursos.
- Terraform instalado en tu máquina local.
- Una llave SSH en AWS para acceder a la máquina (necesario para crear la VM, pero no para acceder por RDP).
- Dado que el archivo principal de terraform se va a cargar en el repositorio de código con todo el proyecto, claramente no podemos almacenar ningún dato sensible. Así que pongamos la clave secreta y la clave de acceso en un archivo diferente, y coloquemos este archivo en nuestro gitignore.
Para separar los datos sensibles, crea un archivo en el mismo directorio llamado terraform.tfvars. Y decláralos así:

# Application Definition 
- app_name        = "serverwindows" # Do NOT enter any spaces

# AWS Settings
- aws_access_key = "aws_access_key"
- aws_secret_key = "aws_secret_key"

# Windows Virtual Machine
- windows_instance_name               = "winsrv01"
- windows_instance_type               = "t2.micro"
- windows_root_volume_size            = 30
- windows_root_volume_type            = "gp2"

## Pasos de ejecución
Clona este repositorio:
- git clone https://github.com/David-19960111/ProjectDevopsTerraform
- Abre el archivo variables.tf y realiza las siguientes modificaciones:
- Cambia el valor de region para seleccionar la región de AWS donde deseas crear la máquina virtual. Si es necesario, cambia el valor de ami para seleccionar la AMI de Windows que prefieras. Verifica la configuración de key_name para asegurarte de que corresponde al nombre de tu llave SSH en AWS.

1. Ejecuta el siguiente comando para inicializar el directorio de trabajo de Terraform:
- terraform init

2. Antes de crear los recursos, verifica qué recursos se crearán con el siguiente comando:
- terraform plan

3. Si la salida del comando terraform plan es correcta, procede a crear la máquina virtual con el siguiente comando:
- terraform apply

Será necesario confirmar la creación de los recursos escribiendo "yes" cuando se te solicite.

- Una vez que la máquina virtual esté creada, puedes obtener la dirección IP pública asignada a ella desde la salida del comando terraform apply.
- Configura el acceso remoto a la máquina virtual mediante RDP utilizando la dirección IP pública obtenida en el paso anterior.

## Acceso remoto a la máquina virtual
Para acceder a la máquina virtual de forma remota, sigue estos pasos:

- Abre el cliente de RDP en tu máquina local.
- Ingresa la dirección IP pública de la máquina virtual como destino.
- Usa las credenciales de acceso configuradas en la instancia de Windows para iniciar sesión.

- ¡Listo! Ahora puedes acceder a tu máquina virtual de Windows desde tu máquina local de forma remota.

## Output del terraform plan

 terraform plan --out plan.out
aws_eip.windowsserver-eip: Refreshing state... [id=eipalloc-0c10e67b89f090b37]
aws_security_group.serverwindows-sg: Refreshing state... [id=sg-0112071aab9a3ebc1]
aws_instance.serverwindows: Refreshing state... [id=i-0b2d584b7d495fd05]
aws_eip_association.serverwindows-eip: Refreshing state... [id=eipassoc-099762a084e8d976b]

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  aws_eip_association.serverwindows-eip must be replaced
-/+ resource "aws_eip_association" "serverwindows-eip" {
      ~ id                   = "eipassoc-099762a084e8d976b" -> (known after apply)
      ~ instance_id          = "i-0b2d584b7d495fd05" # forces replacement -> (known after apply) # forces replacement
      ~ network_interface_id = "eni-039c37ce166ebf5cc" -> (known after apply)
      ~ private_ip_address   = "172.31.49.179" -> (known after apply)
      ~ public_ip            = "54.165.166.150" -> (known after apply)
        # (1 unchanged attribute hidden)
    }

  aws_instance.serverwindows must be replaced
-/+ resource "aws_instance" "serverwindows" {
      ~ arn                                  = "arn:aws:ec2:us-east-1:233505878664:instance/i-0b2d584b7d495fd05" -> (known after apply)
      ~ associate_public_ip_address          = true -> false # forces replacement
      ~ availability_zone                    = "us-east-1e" -> (known after apply)
      ~ cpu_core_count                       = 1 -> (known after apply)
      ~ cpu_threads_per_core                 = 1 -> (known after apply)
      ~ disable_api_stop                     = false -> (known after apply)
      ~ disable_api_termination              = false -> (known after apply)
      ~ ebs_optimized                        = false -> (known after apply)
      - hibernation                          = false -> null
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      ~ id                                   = "i-0b2d584b7d495fd05" -> (known after apply)
      ~ instance_initiated_shutdown_behavior = "stop" -> (known after apply)
      + instance_lifecycle                   = (known after apply)
      ~ instance_state                       = "running" -> (known after apply)
      ~ ipv6_address_count                   = 0 -> (known after apply)
      ~ ipv6_addresses                       = [] -> (known after apply)
      ~ monitoring                           = false -> (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      ~ placement_partition_number           = 0 -> (known after apply)
      ~ primary_network_interface_id         = "eni-039c37ce166ebf5cc" -> (known after apply)
      ~ private_dns                          = "ip-172-31-49-179.ec2.internal" -> (known after apply)
      ~ private_ip                           = "172.31.49.179" -> (known after apply)
      ~ public_dns                           = "ec2-54-165-166-150.compute-1.amazonaws.com" -> (known after apply)
      ~ public_ip                            = "54.165.166.150" -> (known after apply)
      ~ secondary_private_ips                = [] -> (known after apply)
      ~ security_groups                      = [
          - "serverwindows-rdp-sg",
        ] -> (known after apply)
      + spot_instance_request_id             = (known after apply)
        tags                                 = {
            "Name"  = "serverwindows"
            "OWNER" = "david11011996@gmail.com"
        }
      ~ tenancy                              = "default" -> (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      ~ vpc_security_group_ids               = [
          - "sg-0112071aab9a3ebc1",
        ] -> (known after apply)
        # (8 unchanged attributes hidden)

      - capacity_reservation_specification {
          - capacity_reservation_preference = "open" -> null
        }

      - cpu_options {
          - core_count       = 1 -> null
          - threads_per_core = 1 -> null
        }

      - credit_specification {
          - cpu_credits = "standard" -> null
        }

      - enclave_options {
          - enabled = false -> null
        }

      - maintenance_options {
          - auto_recovery = "default" -> null
        }

      - metadata_options {
          - http_endpoint               = "enabled" -> null
          - http_put_response_hop_limit = 1 -> null
          - http_tokens                 = "optional" -> null
          - instance_metadata_tags      = "disabled" -> null
        }

      - private_dns_name_options {
          - enable_resource_name_dns_a_record    = false -> null
          - enable_resource_name_dns_aaaa_record = false -> null
          - hostname_type                        = "ip-name" -> null
        }

      ~ root_block_device {
          ~ device_name           = "/dev/sda1" -> (known after apply)
          ~ encrypted             = false -> true # forces replacement
          ~ iops                  = 100 -> (known after apply)
          + kms_key_id            = (known after apply)
          - tags                  = {} -> null
          ~ throughput            = 0 -> (known after apply)
          ~ volume_id             = "vol-0888c9cf4dd393de5" -> (known after apply)
            # (3 unchanged attributes hidden)
        }
    }

  aws_security_group.serverwindows-sg must be replaced
-/+ resource "aws_security_group" "serverwindows-sg" {
      ~ arn                    = "arn:aws:ec2:us-east-1:233505878664:security-group/sg-0112071aab9a3ebc1" -> (known after apply)
      ~ description            = "acceso remoto para administracion del equipo" -> "Acceso remoto" # forces replacement
      ~ id                     = "sg-0112071aab9a3ebc1" -> (known after apply)
        name                   = "serverwindows-rdp-sg"
      + name_prefix            = (known after apply)
      ~ owner_id               = "233505878664" -> (known after apply)
      - tags                   = {} -> null
      ~ tags_all               = {} -> (known after apply)
        # (4 unchanged attributes hidden)
    }

Plan: 3 to add, 0 to change, 3 to destroy.

───────────────────────────────────────────────────────────────────────────────────────

Saved the plan to: plan.out

To perform exactly these actions, run the following command to apply:
    terraform apply "plan.out"

## Limpieza de recursos
- Una vez que hayas terminado de utilizar la máquina virtual, asegúrate de eliminar los recursos creados para evitar costos innecesarios. Para hacerlo, ejecuta el siguiente comando:

- terraform destroy

Recuerda confirmar la eliminación de los recursos escribiendo "yes" cuando se te solicite.