package Classes
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.controls.Alert;
	import mx.core.Application;
	
	public class UrlServices
	{
		public static const URL_SERVER_DATA_SERVICES:String = "urlServerDataService";
		public static const URL_SERVER_WSAS:String = "urlServerWsas";
		public static const URL_SERVER_ALFRESCO:String = "urlServerAlfresco";
		public static const URL_SERVER_LOTUS:String = "urlServerLotus";
		public static const URL_SERVER_ONLY_SERVICE:String = "onlyService";
				
		private const SERVICE_NAME:String = "service";
		private const SERVICE_ATTRIBUTE:String = "name";
		
		private var dataXML:XMLList;		
		private var urlDataService:String;
		private var urlWsas:String;
		private var urlAlfresco:String;
		private var urlLotus:String;
		
		private var resultFunction:Function;
		
		public function UrlServices()
		{	
			//this.resultFunction = resultFunction;
			
			 Alert.buttonWidth = 200;
			 Alert.buttonHeight= 60;
			try {
				var loader:URLLoader = new URLLoader();
				loader.load(new URLRequest("Data/dataService.xml"));
	         	loader.addEventListener(Event.COMPLETE, loaderServices);	         	
	        }catch (e:Error) {
	          	Alert.show("Problemas con carga de archivos de configuración");
	        }
		}
		
		private function loaderServices(event:Event):void {
			this.dataXML = XMLList(event.target.data);
			this.urlDataService = dataXML.child(URL_SERVER_DATA_SERVICES);
			this.urlWsas = dataXML.child(URL_SERVER_WSAS);
			this.urlAlfresco = dataXML.child(URL_SERVER_ALFRESCO);
			this.urlLotus = dataXML.child(URL_SERVER_LOTUS);
			//this.resultFunction();
			Application.application.limpiaCache();
			
		}
		
		public function getUrlDataService(service:String):String {
			return urlDataService + dataXML.child(SERVICE_NAME).(attribute(SERVICE_ATTRIBUTE) == service).toString();
		}
		
		public function getUrlWsas(service:String):String {
			return urlWsas + dataXML.child(SERVICE_NAME).(attribute(SERVICE_ATTRIBUTE) == service).toString();
		}
		
		public function getUrlAlfresco(service:String):String {
			return urlAlfresco + dataXML.child(SERVICE_NAME).(attribute(SERVICE_ATTRIBUTE) == service).toString();
		}
		
		public function getUrlLotus(service:String):String {
			return urlLotus + dataXML.child(SERVICE_NAME).(attribute(SERVICE_ATTRIBUTE) == service).toString();
		}
		
		public function getUrlOnlyService(service:String):String {
			return dataXML.child(service).toString();
		}
	}
}