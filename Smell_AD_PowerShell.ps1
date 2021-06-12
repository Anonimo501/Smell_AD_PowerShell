echo ""
echo " ***** Anonimo501 *****"
echo ""
echo " ******** Usuario ******** "
echo ""
whoami
echo ""
echo " ******** Nombre de Dominio ******** "
echo ""
$env:USERDNSDOMAIN
echo ""
echo " ******** Bosque o Dominio ******** "
echo ""
Get-ADForest
echo ""
echo " ******** Nombre de Dominio ******** "
echo ""
(Get-ADDomain).DNSRoot
echo ""
echo " ******** DNS - Nombre NetBios y SIS ******** "
echo ""
Get-ADDomain | select DNSRoot,NetBIOSName,DomainSID
echo ""
echo " ******** Obtener el modo del Bosque/Dominio ********* "
echo ""
(Get-ADForest).ForestMode
echo ""
(Get-ADDomain).DomainMode
echo "" 
echo " ******** Fideicomisos/Lista de confianza de dominio ********"
echo ""
nltest /domain_trusts
echo ""
echo " ******** Usuarios Importantes ******** "
echo ""
Get-ADUser -Filter * | select SamAccountName
echo ""
echo " ******** Todos los usuarios del dominio ******** "
echo ""
Get-ADObject -LDAPFilter "objectClass=User" -Properties SamAccountName | select SamAccountName
echo ""
echo " ******** Cuentas Fiduciarias ******** "
echo ""
Get-ADUser -LDAPFilter "(SamAccountName=*$)" | select SamAccountName
echo ""
echo " ******** Listado de Grupos del Dominio ******** "
echo ""
Get-ADGroup -Filter * | select SamAccountName
echo ""
echo " ******** Grupo Administradores del Dominio ******** "
echo ""
Get-ADGroup "Admins. del dominio" -Properties members,memberof
echo ""
echo " ******** Usuario que ejecuta el servicio mysql ******** "
echo ""
Get-WmiObject win32_service -Filter "name='mysql'" | select -ExpandProperty startname
echo ""
echo " ******** SID del Dominio Actual ******** "
echo ""
$(Get-ADDomain).DomainSID.Value
echo ""
echo " ******** SID de Usuario Administrador ******** "
echo ""
$(Get-ADUser Administrador).SID.Value
echo ""
echo " ******** Lista de particiones de base de datos ******** "
echo ""
Import-Module ActiveDirectory
cd AD:
ls
cd C:
echo ""
echo " ******** Sitios en ls particion de Configuracion ******** "
echo ""
Get-ADObject -LDAPFilter "(objectclass=site)" -SearchBase "CN=Configuration, $((Get-ADDomain).DistinguishedName)" | select name
echo ""
echo " ******** Enumeracion de catalogos globales del dominio ********* "
echo ""
Get-ADForest |select -ExpandProperty GlobalCatalogs
echo ""
echo " ******** Usuarios que utilizan ADWS ******** "
echo ""
Get-ADUser -Filter * | select name
echo ""
echo " ********* Lista de bloqueo de consultas globales de DNS ********* "
echo ""
Get-DnsServerGlobalQueryBlockList
echo ""
echo " ********* msDS-allowedToDelegateTo ********* "
echo ""
Get-ADUser Administrador -Properties msDS-AllowedToDelegateTo
echo ""
echo " ********* Enumeracion de dominios y unidades organizativas con GPO vinculados ********* "
echo ""
Get-ADObject -LDAPFilter '(gPLink=*)' -Properties CanonicalName,gpLink | select obkectclass, CanonicalName, gplink | Format-List
echo ""
echo " + Gracias por usar el script de Anonimo501 + "
echo ""