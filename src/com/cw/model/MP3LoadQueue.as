////////////////////////////////////////////////////////////////////////////////
//  Christian Worley Development & Design
//  Copyright 2012 Christian Worley Development & Design
//  All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Package Declaration
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
package com.cw.model {
	/**
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * class description: MP3LoadQueue
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0
	 * author: christian
	 * created: Jan 5, 2012
	 * TODO:
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 */
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	import com.cw.control.observer.IObserver;
	import com.cw.control.observer.ISubject;
	import com.cw.control.observer.InvokedObserver;
	import com.cw.utilities.loaders.FontSWFLoader;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	import com.greensock.loading.XMLLoader;
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class MP3LoadQueue {
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var fontLoadObserver:ISubject = new InvokedObserver();
		private var loadSWFFonts:FontSWFLoader = new FontSWFLoader();
		private var queue1:XMLLoader
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function MP3LoadQueue () {}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function initMP3LoadQueue ():void {
			loadMp3();
			loadFont();
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		/**
		 * Load external fonts. Must match font used in CSS doc.
		 *
		 */
		private function loadFont ():void {
			loadSWFFonts.fontSWFLoaderInterface('./fonts/fontENTrebuchetMS.swf');
			loadSWFFonts.observableInstanceRef(fontLoadObserver);
			loadSWFFonts.observableInstanceRef(fontLoadObserver);
		}
		private function loadMp3 ():void {
			LoaderMax.activate([MP3Loader]);
			queue1 = new XMLLoader("xml/mp3List.xml", {onProgress: progressHandler, onComplete: completeHandler, estimatedBytes: 50000});
			queue1.load();
		}
		private function progressHandler (event:LoaderEvent):void {
			trace("progress: " + event.target.progress);
		}
		/**
		 * On complete grab the LoaderMax named "queueTrack2" that was defined
		 * in the XML and start loading it now.
		 */
		private function completeHandler (event:LoaderEvent):void {
			var mp3Array:Array;
			mp3Array = queue1.getChildren(true, true);
			trace(" ::::::::::: MP3LoadQueue.completeHandler(event) " + '\n' + event.target.name + '\n' + mp3Array + '\n' + mp3Array.length);
			loadCompleteHandler();
		}
		private function loadCompleteHandler ():void {
			var xmlQueue:LoaderMax = LoaderMax.getLoader("mp3Queue");
			var xmlArray:Array = xmlQueue.content;
			trace(" ::::::::::: MusicPlayerState.setState(state) " + xmlArray.length);
		}
	}
}
