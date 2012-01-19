package com.cw.utilities.loaders{
	/**
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * externalCSS Class with both embeded fonts, html formatting and 
	 * external css.
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0
	 * author: Christian Worley
	 * created: 09/2011
	 * TODO; external font sorage in .swf files for localization,
	 * working version useing greensock CSSloader
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 */
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	import com.cw.control.observer.IObserver;
	import com.cw.control.observer.ISubject;
	import com.cw.control.observer.InvokedObserver;
	import com.cw.utilities.loaders.swfExplorer.SWFExplorer;
	import com.cw.utilities.loaders.swfExplorer.events.SWFExplorerEvent;
	import flash.display.Loader;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.text.Font;
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class FontSWFLoader implements ISubject{
		public static var NAME_CHANGED:String="nameChanged";
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var _name:String;
		private var fonts:Array
		private var fontSWFURL:String;
		private var fontSWFLoader:Loader = new Loader();
		private var explorer:SWFExplorer = new SWFExplorer();
		private var fontLoadObserver:ISubject;
		/**
		 * 1. create a .fla doc and in the library create a new libaray font 
		 * class.
		 * 2. select the font you wish to use, embbed the charecters you wish 
		 * to use.
		 * 3. select the ActionScript tab and export for ActionScript. Make sure 
		 * your class name does not match the font name as listed in the font
		 * info window.
		 * 4. compile your .swf and target it's location below.
		 */
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function FontSWFLoader(){};
		/**
		 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		 * 1. pass the interface the font swf URL.
		 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		 */
		public function fontSWFLoaderInterface(fontSWFURL:String):void{
			this.fontSWFURL = fontSWFURL;
			swfXplorerLoad()
		}
		public function observableInstanceRef(fontLoadObserver:ISubject):void{
			this.fontLoadObserver = fontLoadObserver;
			fontLoadObserver.addObserver(this)
		}
		/**
		 * InvokedObserver interface, reference update, and subscription with
		 * updated observer and adding subscription with addObserver(this).
		 */
		public function addObserver (observer:ISubject):void {
//			this.observer = observer;
//			observer.addObserver(this);
		}
		/**
		 * InvokedObserver notification
		 */
		public function notifyObservers (infoObject:String):void {
//			observer.notifyObservers(theButtonState);
		}
		/**
		 * remove an observer refrence from InvokedObserver
		 */
		public function removeObserver (observer:ISubject):void {
		}
		public function update(infoObject:Object):void {
			trace('@ FontSWFLoader' + ' ' + infoObject);
		}
		/**
		 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		 * 1. enter the class name of your fonts as the string value below to 
		 * add your loaded swf font class to your application.
		 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		 */
		private function swfXplorerLoad():void{
			explorer.load ( new URLRequest ( fontSWFURL));
			explorer.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgress);
			explorer.addEventListener ( SWFExplorerEvent.COMPLETE, assetsReady, false );
		}
		private function loadProgress(event:ProgressEvent):void {
			var percentLoaded:Number = event.bytesLoaded/event.bytesTotal;
			percentLoaded = Math.round(percentLoaded * 100);
		}
		private function assetsReady (explorerEvent:SWFExplorerEvent):void{
			var domain:ApplicationDomain = explorer.contentLoaderInfo.applicationDomain;
			var fontClass:Class;
			for (var i:int = 0; i < explorerEvent.target.getTotalDefinitions(); i++){
				fontClass = domain.getDefinition(explorerEvent.definitions[i]) as Class;
				Font.registerFont(fontClass);
			}
			fontLoadObserver.notifyObservers('fonts are loaded');
			fontCheck();
		}
		/**
		 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		 * 1. list loaded fonts in console.
		 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		 */
		private function fontCheck():void{
			fonts = Font.enumerateFonts();
			for (var i:int = 0; i < fonts.length; i++){
				trace('fonts loaded:\n' + fonts[i].fontName + " - " + fonts[i].fontStyle + " - " + fonts[i].fontType);
			}
		}
	}
}