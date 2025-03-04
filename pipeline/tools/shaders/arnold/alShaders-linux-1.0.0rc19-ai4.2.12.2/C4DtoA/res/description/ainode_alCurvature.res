CONTAINER AINODE_ALCURVATURE
{
	NAME ainode_alCurvature;

	INCLUDE GVbase;

	GROUP C4DAI_ALCURVATURE_MAIN_GRP
	{
		DEFAULT 1;

		AIPARAM C4DAIP_ALCURVATURE_MODE {}
		AIPARAM C4DAIP_ALCURVATURE_SAMPLES {}
		AIPARAM C4DAIP_ALCURVATURE_SAMPLERADIUS {}
		AIPARAM C4DAIP_ALCURVATURE_TRACESET {}
		GROUP C4DAI_ALCURVATURE_REMAP_GRP
		{
			AIPARAM C4DAIP_ALCURVATURE_RMPINPUTMIN {}
			AIPARAM C4DAIP_ALCURVATURE_RMPINPUTMAX {}
			GROUP C4DAI_ALCURVATURE_CONTRAST_GRP
			{
				DEFAULT 1;

				AIPARAM C4DAIP_ALCURVATURE_RMPCONTRAST {}
				AIPARAM C4DAIP_ALCURVATURE_RMPCONTRASTPIVOT {}
			}

			GROUP C4DAI_ALCURVATURE_BIAS_AND_GAIN_GRP
			{
				DEFAULT 1;

				AIPARAM C4DAIP_ALCURVATURE_RMPBIAS {}
				AIPARAM C4DAIP_ALCURVATURE_RMPGAIN {}
			}

			AIPARAM C4DAIP_ALCURVATURE_RMPOUTPUTMIN {}
			AIPARAM C4DAIP_ALCURVATURE_RMPOUTPUTMAX {}
			GROUP C4DAI_ALCURVATURE_CLAMP_GRP
			{
				DEFAULT 1;

				AIPARAM C4DAIP_ALCURVATURE_RMPCLAMPENABLE {}
				AIPARAM C4DAIP_ALCURVATURE_RMPTHRESHOLD {}
				AIPARAM C4DAIP_ALCURVATURE_RMPCLAMPMIN {}
				AIPARAM C4DAIP_ALCURVATURE_RMPCLAMPMAX {}
			}

		}

	}
}

