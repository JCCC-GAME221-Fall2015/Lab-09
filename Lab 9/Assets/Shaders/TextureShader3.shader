// TextureShader3.shader
Shader "Custom/TextureShader3" // Lab 9 Shader for On Your Own #3
	{
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_MainTex("Diffuse Texture", 2D) = "white" {}
	}

	SubShader {
		Pass{
			
			Tags{"LightMode" = "ForwardBase"}
			CGPROGRAM
			#pragma vertex vertexFunction
			#pragma fragment fragmentFunction
			
			//user defined variables
			uniform float4 _Color;
			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;
			
			//unity defined variables
			uniform float3 _LightColor0;
			
			//input struct
			struct inputStruct
			{
				float4 vertexPos : POSITION;
				float3 vertexNormal : NORMAL;
				float4 textureCoord : TEXCOORD0;
			};
			
			//output struct
			struct outputStruct
			{
				float4 pixelPos: SV_POSITION;
				float4 colour : COLOR;
				float4 tex: TEXCOORD0;
			};
			
			//vertex program
			outputStruct vertexFunction(inputStruct input)
			{
				outputStruct toReturn;
				float3 lightDirection;

				//Pulling the ambient Light from UNITY 
				float3 ambientLight = UNITY_LIGHTMODEL_AMBIENT.rgb;

				//Get the direction of the light from unity, and normalize it!
				lightDirection = normalize(_WorldSpaceLightPos0.xyz);

				//Grab the normal from the input 
				float3 tempNorm = input.vertexNormal;

				//Convert normal from World to Object space
				float4 objNorm = mul(float4(tempNorm, 1.0), _World2Object);

				//Normalize the normal
				float3 normalizedNormal = normalize(objNorm).xyz;

				// light color * color of object * dot product between light and direction of normal 
				float3 diffuseReflection = _LightColor0.xyz * _Color.rgb * max(0.0, dot(normalizedNormal, lightDirection));

				//Calc final light
				float3 finalLight = diffuseReflection + ambientLight;

				//Output the Colour	
				toReturn.colour = float4(finalLight, 1.0);

				toReturn.pixelPos = mul(UNITY_MATRIX_MVP, input.vertexPos);
				toReturn.tex = input.textureCoord;
				
				return toReturn;
			}
			
			//fragment program
			float4 fragmentFunction(outputStruct input) : COLOR
			{
				float4 tex = tex2D(_MainTex, _MainTex_ST.xy * input.tex.xy + _MainTex_ST.zw);
		
				return float4(tex.rgb * input.colour.rgb, 1.0);
			}
			ENDCG
		} 
	}
	
	//Fallback
	//FallBack "Diffuse"
}
