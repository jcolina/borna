package Validaciones
{
	import mx.controls.Alert;
	import mx.events.ValidationResultEvent;
	import mx.validators.Validator;
	
	public class Validar
	{
		
		public static function validarCampos(validadores:Array):Boolean{			
			if (!validarDatos(validadores, "Campos Requeridos")){
				return false;			
			}	
			return true;
		}

		private static function validarDatos(arrayCamposVali:Array, titleMsg:String):Boolean{
			try {
				var bValidar:Boolean = false;
				var errors:Array = Validator.validateAll(arrayCamposVali);
				if(!errors.length == 0){
					var err:ValidationResultEvent;
					var errorMsg:Array = new Array();
					for each (err in errors) {
						errorMsg.push(Object(err.currentTarget.source).name +": " + err.message);
					}
					Alert.show(errorMsg.join("\n\n"), titleMsg);
					bValidar = false;
				}else{
					bValidar = true;
				}
			}catch(e:Error){
				Alert.show("Error al Validar los campos obligatorios :" + e.message, "Aviso");
			}	
			return bValidar;			
		}
	}
}