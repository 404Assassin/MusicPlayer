package com.cw.utilities.preloaders{
	import com.greensock.events.LoaderEvent;
	import flash.display.MovieClip;
	import flash.display.Stage;
	
	public interface IPreload{
		function preloaderInterface(stageReference:Stage, placementTarget:MovieClip):void ;
		function progressHandlerInterface(loaderEvent:LoaderEvent):void ;
	}
}