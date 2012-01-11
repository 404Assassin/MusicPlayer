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
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.XMLLoader;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.MP3Loader;
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class MP3LoadQueue {
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function MP3LoadQueue () {}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function initMP3LoadQueue():void{
			loadMp3 ();
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private function loadMp3 ():void {
			LoaderMax.activate([MP3Loader]);
			var loader:XMLLoader = new XMLLoader("xml/mp3List.xml", {onProgress: progressHandler, onComplete: completeHandler, estimatedBytes: 50000});
			loader.load();
		}
		private function progressHandler (event:LoaderEvent):void {
			trace("progress: " + event.target.progress);
		}
		/**
		 * On complete grab the LoaderMax named "queueTrack2" that was defined
		 * in the XML and start loading it now.
		 */
		private function completeHandler (event:LoaderEvent):void {
			var queue2:LoaderMax = LoaderMax.getLoader("queueTrack2");
			queue2.addEventListener(LoaderEvent.COMPLETE, queue2CompleteHandler);
			queue2.addEventListener(LoaderEvent.PROGRESS, progressHandler);
			queue2.load();
		}
		private function queue2CompleteHandler (event:LoaderEvent):void {
			trace("queue2 loaded!");
		}
	}
}
