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
	import com.greensock.loading.CSSLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	import com.greensock.loading.SelfLoader;
	import com.greensock.loading.XMLLoader;
	import flash.display.Sprite;

	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class MP3LoadQueue implements ISubject {
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var fontLoadObserver:ISubject = new InvokedObserver();
		private var loadSWFFonts:FontSWFLoader = new FontSWFLoader();
		private var observer:ISubject;
		private var queue1:LoaderMax;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function MP3LoadQueue () {}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function initMP3LoadQueue ():void {
			loadFont();
			loadMp3();
		}
		/**
		 * InvokedObserver interface, reference update, and subscription with
		 * updated observer and adding subscription with addObserver(this).
		 */
		public function addObserver (observer:ISubject):void {
			this.observer = observer;
			observer.addObserver(this);
		}
		/**
		 * InvokedObserver notification
		 */
		public function notifyObservers (infoObject:String):void {
			observer.notifyObservers(infoObject);
		}
		/**
		 * remove an observer refrence from InvokedObserver
		 */
		public function removeObserver (observer:ISubject):void {
		}
		public function update (infoObject:String):void {
			try {
				this[infoObject]();
			} catch(error:Error) {
				//trace(" ::::::::::: skip non methods!!!!! ");
			}
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		/**
		 * Load external fonts. Must match font used in CSS doc.
		 */
		private function loadFont ():void {
			loadSWFFonts.fontSWFLoaderInterface('./fonts/fontENTrebuchetMS.swf');
			loadSWFFonts.observableInstanceRef(fontLoadObserver);
		}
		private function loadMp3 ():void {
			LoaderMax.activate([MP3Loader, CSSLoader, XMLLoader]);
			queue1 = new LoaderMax({name: "mainQueue", onChildOpen: onChildOpenHandler, onProgress: progressHandler, onComplete: completeHandler, onChildProgress: onChildProgressHandler, onChildComplete: onChildCompleteHandler, onError: errorHandler});
			queue1.append(new CSSLoader("./css/flashSiteStyles.css", {name: "flashStyleSheet", alternateURL: "http://worleydev.com/css/flashSiteStyles.css"}));
			queue1.append(new XMLLoader("./xml/mp3List.xml", {}));
			queue1.load();
		}
		private function onChildOpenHandler (event:LoaderEvent):void {
			trace(" ::::::::::: MP3LoadQueue.onChildOpenHandler() ");
			if(event.target.name == 'track1') {
				trace(" ::::::::::: MP3LoadQueue.onChildOpenHandler()  if(event.target.name =='track1')");
				notifyObservers('firstTractLoading');
			}
		}
		private function progressHandler (event:LoaderEvent):void {
			trace("progress: " + event.target.progress);
		}
		private function onChildProgressHandler (event:LoaderEvent):void {
			trace("child progress: " + event.target.progress);
		}
		private function completeHandler (event:LoaderEvent):void {
			var mp3Array:Array;
			mp3Array = queue1.getChildren(true, true);
			trace(" ::::::::::: MP3LoadQueue.completeHandler(event) " + '\n' + event.target.name + '\n' + mp3Array + '\n' + mp3Array.length);
//			notifyObservers('externalContentLoaded');
		}
		private function onChildCompleteHandler (event:LoaderEvent):void {
			trace(" ::::::::::: MP3LoadQueue.completeHandler(event) " + '\n' + event.target.name + '\n' /* + mp3Array + '\n' + mp3Array.length*/);
			if(event.target.name == 'track1') {
				trace(" ::::::::::: MP3LoadQueue.onChildCompleteHandler(event) if(event.target.name =='track1')");
				notifyObservers('firstTractLoaded');
				notifyObservers('play');
			}
		}
		private function errorHandler (event:LoaderEvent):void {
			trace(" ::::::::::: MP3LoadQueue.errorHandler(event) " + '\n' + event);
		}
	}
}
