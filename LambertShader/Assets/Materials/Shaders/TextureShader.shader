Shader "Custom/TextureShader"
{
	Properties
	{
		_Color ("Color Tint", Color) = (1,1,1,1)
		_MainTex("Diffuse Texture", 2D) = "white"{}
	}
	SubShader
	{
		Pass
		{
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
					float4 textureCoord : TEXCOORD0;
					float4 vertexNormal : NORMAL;
				};
				
				//output struct
				struct outputStruct
				{	
					float4 pixelPos : SV_POSITION;
					float4 tex : TEXCOORD0;
					float4 colour : COLOR;
				};
				
				
				//vertex program
				outputStruct vertexFunction(inputStruct input)
				{
					outputStruct toReturn;
					
					
					float3 lightDirection;
					float attenuation = 1.0; //not working with this yet.
											//falloff of light as the light gets further away.

					//pulling the ambient light from unity.
					float3 ambientLight = UNITY_LIGHTMODEL_AMBIENT.rgb;	
					
					//Get the direction of the light from unity, and normalize it!
					lightDirection = normalize(_WorldSpaceLightPos0.xyz);

					float3 tempNorm = input.vertexNormal;				
					//Convert to normal from World to Object space
					float3 objectNorm = normalize(mul(float4(tempNorm, 1.0), _World2Object).xyz); //Convert out normal from world to ojbect space
					
					
					//Dot product between light direction and the normal
					float3 difuseReflection = attenuation * _LightColor0.xyz * _Color.rgb * max(0.0, dot(objectNorm, lightDirection));
					
					float3 finalLight = difuseReflection + ambientLight;
					
					//Assigning the information that th einputStruct gathered
					//to the struct that will be passed into the fragment program
					//so that the fragment program can use it.
					toReturn.tex = input.textureCoord;
					toReturn.colour = float4(finalLight, 1.0);
					toReturn.pixelPos = mul(UNITY_MATRIX_MVP, input.vertexPos);
					
					return toReturn;
				}
				
				//fragment program
				float4 fragmentFunction(outputStruct input) : Color
				{
									//Texture, 	Scale the texture by the user input, + offset //(Currently Flipped)
					float4 tex = tex2D(_MainTex, _MainTex_ST.zw + _MainTex_ST.xy * input.tex.xy);
					
					return tex * input.colour;
					
				}
			ENDCG
		}
	}
	
	//fallback
	//fallback "Diffuse"
}