package com.jmv.sbejeweled
{
	/**
	 *
	 * @author Patricio @ sismogames
	 */
	public class settingsEmbed
	{	
		
		[Embed(source="/./settings.xml", mimeType="text/xml")]
		private static const data:Class
		
		public static const xml:XML = data["data"] as XML;
	}

}
