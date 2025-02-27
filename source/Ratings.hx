import flixel.FlxG;

class Ratings
{
    public static function GenerateLetterRank(accuracy:Float) // generate a letter ranking
    {
        var ranking:String = "N/A";
		if(FlxG.save.data.botplay && !PlayState.loadRep)
			ranking = "BotPlay";

       /* if (PlayState.misses == 0 && PlayState.bads == 0 && PlayState.shits == 0 && PlayState.goods == 0) // Marvelous (SICK) Full Combo
            ranking = "(MFC)";
        else if (PlayState.misses == 0 && PlayState.bads == 0 && PlayState.shits == 0 && PlayState.goods >= 1) // Good Full Combo (Nothing but Goods & Sicks)
            ranking = "(GFC)";
        else if (PlayState.misses == 0) // Regular FC
            ranking = "(FC)";
        else if (PlayState.misses < 10) // Single Digit Combo Breaks
            ranking = "(SDCB)";
        else */
            ranking = "";

        // WIFE TIME :)))) (based on Wife3)

        var wifeConditions:Array<Bool> = [
            accuracy >= 99.9935, // AAAAA
            accuracy >= 99.980, // AAAA:
            accuracy >= 99.970, // AAAA.
            accuracy >= 99.955, // AAAA
            accuracy >= 99.90, // AAA:
            accuracy >= 99.80, // AAA.
            accuracy >= 99.70, // AAA
            accuracy >= 99, // AA:
            accuracy >= 96.50, // AA.
            accuracy >= 93, // AA
            accuracy >= 90, // A:
            accuracy >= 85, // A.
            accuracy >= 80, // A
            accuracy >= 70, // B
            accuracy >= 60, // C
            accuracy < 60 // D
        ];

        for(i in 0...wifeConditions.length)
        {
            var b = wifeConditions[i];
            if (b)
            {
                switch(i)
                {
                    case 0:
                        ranking += " QUE GIGA PRO";
                    case 1:
                        ranking += " Que Mega Pro:";
                    case 2:
                        ranking += " Que pro en 3D.";
                    case 3:
                        ranking += " Que pro en hd";
                    case 4:
                        ranking += " Que fino:";
                    case 5:
                        ranking += " Que troll.";
                    case 6:
                        ranking += " Que old";
                    case 7:
                        ranking += " Que humano:";
                    case 8:
                        ranking += " Sla kek.";
                    case 9:
                        ranking += " Olha so";
                    case 10:
                        ranking += " Que pro:";
                    case 11:
                        ranking += " Que bizzaro.";
                    case 12:
                        ranking += " Que estranho";
                    case 13:
                        ranking += " Que noob";
                    case 14:
                        ranking += " Que mega noob";
                    case 15:
                        ranking += " Que giga noob";
                }
                break;
            }
        }

        if (accuracy == 0)
            ranking = "Sem resultado";
		else if(FlxG.save.data.botplay && !PlayState.loadRep)
			ranking = "BotPlay";

        return ranking;
    }
    
    public static function CalculateRating(noteDiff:Float, ?customSafeZone:Float):String // Generate a judgement through some timing shit
    {

        var customTimeScale = Conductor.timeScale;

        if (customSafeZone != null)
            customTimeScale = customSafeZone / 166;

        // trace(customTimeScale + ' vs ' + Conductor.timeScale);

        // I HATE THIS IF CONDITION
        // IF LEMON SEES THIS I'M SORRY :(

        // trace('Hit Info\nDifference: ' + noteDiff + '\nZone: ' + Conductor.safeZoneOffset * 1.5 + "\nTS: " + customTimeScale + "\nLate: " + 155 * customTimeScale);

        if (FlxG.save.data.botplay && !PlayState.loadRep)
            return "sick"; // FUNNY
	

        var rating = checkRating(noteDiff,customTimeScale);


        return rating;
    }

    public static function checkRating(ms:Float, ts:Float)
    {
        var rating = "sick";
        if (ms <= 166 * ts && ms >= 135 * ts)
            rating = "shit";
        if (ms < 135 * ts && ms >= 90 * ts) 
            rating = "bad";
        if (ms < 90 * ts && ms >= 45 * ts)
            rating = "good";
        if (ms < 45 * ts && ms >= -45 * ts)
            rating = "sick";
        if (ms > -90 * ts && ms <= -45 * ts)
            rating = "good";
        if (ms > -135 * ts && ms <= -90 * ts)
            rating = "bad";
        if (ms > -166 * ts && ms <= -135 * ts)
            rating = "shit";
        return rating;
    }

    public static function CalculateRanking(score:Int,scoreDef:Int,nps:Int,maxNPS:Int,accuracy:Float):String
    {
        return
         (FlxG.save.data.npsDisplay ?																							// NPS Toggle
         "NPS: " + nps + " (Max " + maxNPS + ")" + (!PlayStateChangeables.botPlay || PlayState.loadRep ? " | " : "") : "") +								// 	NPS
         (!PlayStateChangeables.botPlay || PlayState.loadRep ? "Pontin:" + (Conductor.safeFrames != 10 ? score + " (" + scoreDef + ")" : "" + score) + 		// Score
         (FlxG.save.data.accuracyDisplay ?																						// Accuracy Toggle
         " | Erros:" + PlayState.misses + 																				// 	Misses/Combo Breaks
         " | Nota de matemática:" + (PlayStateChangeables.botPlay && !PlayState.loadRep ? "Sem resultado" : HelperFunctions.truncateFloat(accuracy, 2) + " %") +  				// 	Accuracy
         " | " + GenerateLetterRank(accuracy) : "") : ""); 																// 	Letter Rank
    }
}
