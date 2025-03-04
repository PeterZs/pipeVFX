CONTAINER AINODE_ALHAIR
{
	NAME ainode_alHair;

	INCLUDE GVbase;

	GROUP C4DAI_ALHAIR_MAIN_GRP
	{
		DEFAULT 1;

		GROUP C4DAI_ALHAIR_FIBRE_PROPERTIES_GRP
		{
			DEFAULT 1;

			AIPARAM C4DAIP_ALHAIR_MELANIN {}
			AIPARAM C4DAIP_ALHAIR_DYECOLOR {}
			AIPARAM C4DAIP_ALHAIR_SPECULARWIDTH {}
			AIPARAM C4DAIP_ALHAIR_SPECULARSHIFT {}
			AIPARAM C4DAIP_ALHAIR_OPACITY {}
			GROUP C4DAI_ALHAIR_RANDOMIZE_GRP
			{
				AIPARAM C4DAIP_ALHAIR_RANDOMTANGENT {}
				AIPARAM C4DAIP_ALHAIR_RANDOMMELANIN {}
				AIPARAM C4DAIP_ALHAIR_RANDOMHUE {}
				AIPARAM C4DAIP_ALHAIR_RANDOMSATURATION {}
			}

			GROUP C4DAI_ALHAIR_ADVANCED_1_GRP
			{
				AIPARAM C4DAIP_ALHAIR_GLINTROLLOFF {}
				AIPARAM C4DAIP_ALHAIR_TRANSMISSIONROLLOFF {}
			}

		}

		GROUP C4DAI_ALHAIR_DIFFUSE_GRP
		{
			DEFAULT 1;

			AIPARAM C4DAIP_ALHAIR_DIFFUSESTRENGTH {}
			AIPARAM C4DAIP_ALHAIR_DIFFUSECOLOR {}
			AIPARAM C4DAIP_ALHAIR_DIFFUSESCATTERINGMODE {}
			AIPARAM C4DAIP_ALHAIR_DIFFUSEFORWARD {}
			AIPARAM C4DAIP_ALHAIR_DIFFUSEBACK {}
		}

		GROUP C4DAI_ALHAIR_SPECULAR_1_GRP
		{
			DEFAULT 1;

			AIPARAM C4DAIP_ALHAIR_SPECULAR1STRENGTH {}
			AIPARAM C4DAIP_ALHAIR_SPECULAR1COLOR {}
			AIPARAM C4DAIP_ALHAIR_SPECULAR1WIDTHSCALE {}
			AIPARAM C4DAIP_ALHAIR_SPECULAR1SHIFT {}
		}

		GROUP C4DAI_ALHAIR_SPECULAR_2_GRP
		{
			DEFAULT 1;

			AIPARAM C4DAIP_ALHAIR_SPECULAR2STRENGTH {}
			AIPARAM C4DAIP_ALHAIR_SPECULAR2COLOR {}
			AIPARAM C4DAIP_ALHAIR_SPECULAR2WIDTHSCALE {}
			AIPARAM C4DAIP_ALHAIR_SPECULAR2SHIFT {}
			AIPARAM C4DAIP_ALHAIR_GLINTSTRENGTH {}
		}

		GROUP C4DAI_ALHAIR_TRANSMISSION_GRP
		{
			DEFAULT 1;

			AIPARAM C4DAIP_ALHAIR_TRANSMISSIONSTRENGTH {}
			AIPARAM C4DAIP_ALHAIR_TRANSMISSIONCOLOR {}
			AIPARAM C4DAIP_ALHAIR_TRANSMISSIONWIDTHSCALE {}
			AIPARAM C4DAIP_ALHAIR_TRANSMISSIONSHIFT {}
		}

		GROUP C4DAI_ALHAIR_IDS_GRP
		{
			AIPARAM C4DAIP_ALHAIR_ID1 {}
			AIPARAM C4DAIP_ALHAIR_ID2 {}
			AIPARAM C4DAIP_ALHAIR_ID3 {}
			AIPARAM C4DAIP_ALHAIR_ID4 {}
			AIPARAM C4DAIP_ALHAIR_ID5 {}
			AIPARAM C4DAIP_ALHAIR_ID6 {}
			AIPARAM C4DAIP_ALHAIR_ID7 {}
			AIPARAM C4DAIP_ALHAIR_ID8 {}
		}

		GROUP C4DAI_ALHAIR_AOVS_GRP
		{
			AIPARAM C4DAIP_ALHAIR_CRYPTO_ASSET_OVERRIDE {}
			AIPARAM C4DAIP_ALHAIR_CRYPTO_OBJECT_OVERRIDE {}
			AIPARAM C4DAIP_ALHAIR_CRYPTO_MATERIAL_OVERRIDE {}
			AIPARAM C4DAIP_ALHAIR_AOV_DIFFUSE_COLOR {}
			AIPARAM C4DAIP_ALHAIR_AOV_DIRECT_DIFFUSE {}
			AIPARAM C4DAIP_ALHAIR_AOV_INDIRECT_DIFFUSE {}
			AIPARAM C4DAIP_ALHAIR_AOV_DIRECT_LOCAL {}
			AIPARAM C4DAIP_ALHAIR_AOV_INDIRECT_LOCAL {}
			AIPARAM C4DAIP_ALHAIR_AOV_DIRECT_GLOBAL {}
			AIPARAM C4DAIP_ALHAIR_AOV_INDIRECT_GLOBAL {}
			AIPARAM C4DAIP_ALHAIR_AOV_DIRECT_SPECULAR {}
			AIPARAM C4DAIP_ALHAIR_AOV_INDIRECT_SPECULAR {}
			AIPARAM C4DAIP_ALHAIR_AOV_LIGHT_GROUP_1 {}
			AIPARAM C4DAIP_ALHAIR_AOV_LIGHT_GROUP_2 {}
			AIPARAM C4DAIP_ALHAIR_AOV_LIGHT_GROUP_3 {}
			AIPARAM C4DAIP_ALHAIR_AOV_LIGHT_GROUP_4 {}
			AIPARAM C4DAIP_ALHAIR_AOV_LIGHT_GROUP_5 {}
			AIPARAM C4DAIP_ALHAIR_AOV_LIGHT_GROUP_6 {}
			AIPARAM C4DAIP_ALHAIR_AOV_LIGHT_GROUP_7 {}
			AIPARAM C4DAIP_ALHAIR_AOV_LIGHT_GROUP_8 {}
			AIPARAM C4DAIP_ALHAIR_AOV_ID_1 {}
			AIPARAM C4DAIP_ALHAIR_AOV_ID_2 {}
			AIPARAM C4DAIP_ALHAIR_AOV_ID_3 {}
			AIPARAM C4DAIP_ALHAIR_AOV_ID_4 {}
			AIPARAM C4DAIP_ALHAIR_AOV_ID_5 {}
			AIPARAM C4DAIP_ALHAIR_AOV_ID_6 {}
			AIPARAM C4DAIP_ALHAIR_AOV_ID_7 {}
			AIPARAM C4DAIP_ALHAIR_AOV_ID_8 {}
			AIPARAM C4DAIP_ALHAIR_AOV_CRYPTO_ASSET {}
			AIPARAM C4DAIP_ALHAIR_AOV_CRYPTO_OBJECT {}
			AIPARAM C4DAIP_ALHAIR_AOV_CRYPTO_MATERIAL {}
		}

		GROUP C4DAI_ALHAIR_ADVANCED_GRP
		{
			AIPARAM C4DAIP_ALHAIR_DUALDEPTH {}
			AIPARAM C4DAIP_ALHAIR_DIFFUSEINDIRECTSTRENGTH {}
			AIPARAM C4DAIP_ALHAIR_EXTRASAMPLESDIFFUSE {}
			AIPARAM C4DAIP_ALHAIR_GLOSSYINDIRECTSTRENGTH {}
			AIPARAM C4DAIP_ALHAIR_EXTRASAMPLESGLOSSY {}
			AIPARAM C4DAIP_ALHAIR_UPARAM {}
			AIPARAM C4DAIP_ALHAIR_VPARAM {}
		}

	}
}

