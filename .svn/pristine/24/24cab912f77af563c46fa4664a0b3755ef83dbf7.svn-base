// ActionScript file
import mx.collections.ArrayCollection;
import mx.core.Application;

import org.bytearray.gif.player.GIFPlayer;

public var Opcion:String;
public var Texto:String;

private function initCom():void{
	this.txtAnuncio.text = Texto;
	var myGIFPlayer:GIFPlayer = new GIFPlayer();
	container.addChild(myGIFPlayer);
	myGIFPlayer.load(new URLRequest("assets/wait.gif"));	
	//	System.setClipboard("###APAGANDO$$$EQUIPO$$$BORNA2.0###");	
	//var op:String = "Apagar";
	Application.application.sendHTTPServices("Opciones", recive, Opcion);
	
}
private function recive(evt:ArrayCollection):void{
	
}