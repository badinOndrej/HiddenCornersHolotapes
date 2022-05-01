package bhvr.interfaces 
{
	/**
	 * ...
	 * @author ondbad
	 */
	public interface IExternalCommunication 
	{
		
		function ProcessUserEvent(strEventName:String, abPressed:Boolean):Boolean;
		
		function InitProgram():void;
		
		function SetHighscore(highscore:int):void;
		
	}

}