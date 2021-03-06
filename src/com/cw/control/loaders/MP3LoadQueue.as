////////////////////////////////////////////////////////////////////////////////
//  Christian Worley Development & Design
//  Copyright 2012 Christian Worley Development & Design
//  All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Package Declaration
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
package com.cw.control.loaders {
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
	import com.cw.control.loaders.fontSWFLoader.FontSWFLoader;
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
		private var currentAmount:Number = 0;
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
			if(hasOwnProperty(infoObject)){
				this[infoObject]();
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
			queue1 = new LoaderMax({name:"mainQueue", onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler, auditSize:true});
			queue1.append(new CSSLoader("./css/flashSiteStyles.css", {name:"flashStyleSheet", alternateURL:"http://worleydev.com/css/flashSiteStyles.css"}));
			queue1.append(new XMLLoader("./xml/mp3List.xml", {}));
			queue1.load();
		}
		private function onChildOpenHandler (event:LoaderEvent):void {
			if(event.target.name == 'track1') {
				notifyObservers('firstTractLoading');
			}
		}
		private function progressHandler (event:LoaderEvent):void {
//			trace("main progress: " + event.target.progress);
		}
		private function onChildProgressHandler (event:LoaderEvent):void {
//			trace(" ::::::::::: MP3LoadQueue.onChildProgressHandler(event) "+event.target.progress);
			if((event.target.progress >= .1) && (event.target.name == 'track1')) {
				notifyObservers('play');
			}
			if(currentAmount == 1) {
				currentAmount = 0;
			}
//			trace("child progress current amounts: " + '\n' + currentAmount + '\n' + event.target.progress + '\n' + event.target.name.substring(0, 5));
			if((event.target.name.substring(0, 5) == 'track') && (currentAmount < event.target.progress)) {
//				trace("child progress: " + event.target.progress);
				currentAmount = event.target.progress
				notifyObservers('childProgress' + event.target.progress as String);
			}
		}
		private function completeHandler (event:LoaderEvent):void {
			var mp3Array:Array;
			mp3Array = queue1.getChildren(true, true);
//			trace(" ::::::::::: MP3LoadQueue.completeHandler(event) " + '\n' + event.target.name + '\n' + mp3Array + '\n' + mp3Array.length);
			var queue2:LoaderMax = LoaderMax.getLoader("mp3Queue");
			queue2.addEventListener(LoaderEvent.COMPLETE, mp3QueueCompleteHandler);
			queue2.addEventListener(LoaderEvent.CHILD_PROGRESS, /*mp3QueueProgressHandler*/onChildProgressHandler);
			queue2.addEventListener(LoaderEvent.CHILD_OPEN, onChildOpenHandler);
			queue2.addEventListener(LoaderEvent.CHILD_COMPLETE, onChildCompleteHandler);
			queue2.load();
		}
		private function mp3QueueProgressHandler(event:LoaderEvent):void{
//			trace(" ::::::::::: MP3LoadQueue.mp3QueueProgressHandler(event) " + '\n' + event.target.progress + '\n' );
		}
		private function onChildCompleteHandler (event:LoaderEvent):void {
			if(event.target.name == 'track1') {
				notifyObservers('firstTractLoaded');
				notifyObservers('play');
			}
		}
		private function mp3QueueCompleteHandler(event:LoaderEvent):void{
//			trace(" ::::::::::: MP3LoadQueue.completeHandler(event) " + '\n' + event.target.name + '\n' );
			
		}
		private function errorHandler (event:LoaderEvent):void {
//			trace(" ::::::::::: MP3LoadQueue.errorHandler(event) " + '\n' + event);
		}
	}
}
