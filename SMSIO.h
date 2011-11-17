/*
 *  SMSOutput.h
 *  Unimotion2HID
 *
 *  Created by Marius Petcu on 9/24/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

typedef struct _SMSOutput {
	float x,y,rawx,rawy,rawz,xnodz,ynodz;
} SMSOutput;

typedef struct _SMSInput {
	float sensitx,sensity;
	int mapx,mapy,mapz;
	BOOL invx,invy,filter;
	int dzXmod,dzYmod;
	float dzX1,dzX2,dzY1,dzY2;
} SMSInput;
