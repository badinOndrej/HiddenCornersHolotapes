package util 
{
	/**
	 * ...
	 * @author Ondrej Badin
	 */
	public class MathLib 
	{
		
		public static function remap(num:Number, minOld:Number, maxOld:Number, minNew:Number, maxNew:Number):Number {
			return minNew + (num - minOld) * (maxNew - minNew) / (maxOld - minOld);
		}
		
	}

}