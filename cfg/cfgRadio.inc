class CfgRadio
{
	sounds[] = {};
	class C_FollowConfirm_1
	{
		// display name
		name	= "";
		// filename, volume, pitch
		sound[]	= { "", db - 100, 1.0 };
		// radio caption
		title	= "I'll follow your lead.";
	};
	class C_FollowConfirm_2
	{
		name	= "";
		sound[]	= { "", db - 100, 1.0 }; // .wss implied
		title	= "Get me out of here!";
	};
	class C_FollowConfirm_4
	{
		name	= "";
		sound[]	= { "", db - 100, 1.0 };
		title	= "Lead ahead, I am behind you.";
	};
	class C_FollowConfirm_5
	{
		name	= "";
		sound[]	= { "", db - 100, 1.0 };
		title	= "Hurry, I don't want to die!";
	};
	class C_FollowConfirm_6
	{
		name	= "";
		sound[]	= { "", db - 100, 1.0 };
		title	= "Where are we going?";
	};

    class IDAP_FollowOrder_1
	{
		name	= "";
		sound[]	= { "", db - 100, 1.0 };
		title	= "Follow me!";
	};
    class IDAP_FollowOrder_2
	{
		name	= "";
		sound[]	= { "", db - 100, 1.0 };
		title	= "Stay behind me!";
	};
    class IDAP_FollowOrder_3
	{
		name	= "";
		sound[]	= { "", db - 100, 1.0 };
		title	= "Let's get out of here!";
	};
    class IDAP_FollowOrder_4
	{
		name	= "";
		sound[]	= { "", db - 100, 1.0 };
		title	= "I am here to get you out. Follow my lead!";
	};
    class IDAP_FollowOrder_5
	{
		name	= "";
		sound[]	= { "", db - 100, 1.0 };
		title	= "I'll take you to my vehcile to get you out of here.";
	};
    class IDAP_FollowOrder_6
	{
		name	= "";
		sound[]	= { "", db - 100, 1.0 };
		title	= "I'll bring you somewhere safe. Stay close!";
	};

	class IDAP_fleeOrder_0
	{
		name = "";
		sound[]	= { "", db - 100, 1.0 };
		title	= "Run Forest! Run!";
	};
	class IDAP_fleeOrder_1
	{
		name = "";
		sound[]	= { "", db - 100, 1.0 };
		title	= "Get out of here! Head towards a safe position and stay away from combatants!";
	};
	class IDAP_fleeOrder_2
	{
		name = "";
		sound[]	= { "", db - 100, 1.0 };
		title	= "Hurry to move away from here! There are soldiers closing in on this area. Avoid them and go to safe position.";
	};
	class IDAP_fleeOrder_3
	{
		name = "";
		sound[]	= { "", db - 100, 1.0 };
		title	= "Move! Move! Move! There will be fighting close by! So get yourself to safety!";
	};
	class C_fleeComply_0
	{
		name = "";
		sound[]	= { "", db - 100, 1.0 };
		title	= "Yes, daddy IDAP";
	};
	class C_fleeComply_1
	{
		name = "";
		sound[]	= { "", db - 100, 1.0 };
		title	= "Alright, I'm leaving!";
	};
	class C_fleeComply_2
	{
		name = "";
		sound[]	= { "", db - 100, 1.0 };
		title	= "I'm going as fast as possible!";
	};
	class C_fleeComply_3
	{
		name = "";
		sound[]	= { "", db - 100, 1.0 };
		title	= "Ok, ok! I'll go then!";
	};

	class IDAP_DetainedTalk_1
	{
		name	= "";
		sound[]	= { "", db - 100, 1.0 };
		//title	= "I inquire thee; what foul demises is 'tis you bring upon thy brother? Stop at once or face thy judgment in the face of god and men!";
		title = "Hello there, we are from the International Development and Aid Project and I must ask what you are doing here.";
	};
	class I_DetainedRespond_1
	{
		name	= "";
		sound[]	= { "", db - 100, 1.0 };
		//title	= "'tis but a detention of the ordinary kind. Your eyes must deceive you, for no harm is done, or does it not be so? But to thy hands I commit this soul, for but a burden he would be to us.";
		title = "This is a usual detention. We suspect that sack of shit to cooperate with the enemy but he won't talk. So do whatever you want with him. He's all yours. Come on men, continue on patrol.";
	};
	class IDAP_DetainedFree_1
	{
		name	= "";
		sound[]	= { "", db - 100, 1.0 };
		title	= "Let me help you with this. Have you been harmed?";
	};
	class C_DetainedFreed_1
	{
		name	= "";
		sound[]	= { "", db - 100, 1.0 };
		//title	= "I thank thee good sir! Forevermore I am in thy debt, which not gold nor gem can repay! Thank thee, O savior of mine!";
		title = "No, I think I can handle. I am glad you came. I'll be on my way and thank you!";
	};

};