<?php
	require "Conexion.php";

	class Empleado{
	
		
		public function __construct(){
		}

		public function Registrar($apellidos,$nombre,$tipo_documento,$num_documento,$direccion,$telefono,$email,$fecha_nacimiento,$foto, $login, $clave,$estado){
			global $conexion;
			
			$prueba="SELECT count(*) as cantidad FROM empleado e
			where e.num_documento = '$num_documento'";
			$resul = $conexion->query($prueba);	
			$resp=$resul->fetch_object();
		
			if($resp->cantidad >= 1){
				return false;
			}

			$sql = "INSERT INTO empleado(apellidos,nombre,tipo_documento,num_documento,direccion,telefono,email,fecha_nacimiento,foto, login, clave,estado)
						VALUES('$apellidos','$nombre','$tipo_documento','$num_documento','$direccion','$telefono','$email','$fecha_nacimiento','$foto', '$login', '$clave','$estado')";
			$query = $conexion->query($sql);
			return $query;
			
		}
		
		public function Modificar($idempleado,$apellidos,$nombre, $tipo_documento,$num_documento,$direccion,$telefono,$email,$fecha_nacimiento,$foto, $login, $clave,$estado){
			global $conexion;
			$sql = "UPDATE empleado set apellidos = '$apellidos',nombre = '$nombre',tipo_documento='$tipo_documento',num_documento='$num_documento', direccion = '$direccion' ,telefono	='$telefono',email='$email',fecha_nacimiento='$fecha_nacimiento',foto='$foto',
					login = '$login', clave = '$clave' ,estado='$estado'
						WHERE idempleado = $idempleado";
			$query = $conexion->query($sql);
			return $query;
		}
		
		
		public function Eliminar($idempleado){
			global $conexion;
			$sql = "DELETE FROM empleado WHERE idempleado = $idempleado";
			$query = $conexion->query($sql);
			return $query;
		}

		public function Listar(){
			global $conexion;
			$sql = "SELECT * FROM empleado order by idempleado desc";
			$query = $conexion->query($sql);
			return $query;
		}

		public function Reporte(){
			global $conexion;
			$sql = "SELECT * FROM empleado order by apellidos asc";
			$query = $conexion->query($sql);
			return $query;
		}

		

	}
