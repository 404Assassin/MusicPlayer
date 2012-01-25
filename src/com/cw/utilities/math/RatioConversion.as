package com.cw.utilities.math{
	/**
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * RatioConversion class.
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0
	 * author: Christian Worley
	 * created: 10/2011
	 * TODO; 
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 */
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class RatioConversion{
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var returnedValue:Number;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function RatioConversion(){}
		/**
		 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		 * Pass the interface your; originalValue, the originalMinimum and 
		 * originalMaximum number range and the desired returnedMinimum and
		 * returnedMaximum number range for the ratio converted value.
		 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		 */
		public function ratioConversionInterface(originalValue:Number, originalMinimum:Number, originalMaximum:Number, returnedMinimum:Number, returnedMaximum:Number):Number{
				//var originalValue:Number;
				/*var originalMinimum:Number = 0;
				var originalMaximum:Number = .25;
				var returnedMinimum:Number = 0;
				var returnedMaximum:Number = 1;*/
				returnedValue = ( ( originalValue - originalMinimum ) / (originalMaximum - originalMinimum) ) * (returnedMaximum - returnedMinimum) + returnedMinimum
				return returnedValue
		}
	}
}