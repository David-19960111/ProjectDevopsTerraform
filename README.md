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

## Limpieza de recursos
- Una vez que hayas terminado de utilizar la máquina virtual, asegúrate de eliminar los recursos creados para evitar costos innecesarios. Para hacerlo, ejecuta el siguiente comando:

- terraform destroy

Recuerda confirmar la eliminación de los recursos escribiendo "yes" cuando se te solicite.