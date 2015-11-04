Shader "OnYourOwnShader" {
	//Step 1: change the color tint happens on the material
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Diffuse Texture", 2D) = "white" {}
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
			uniform float3 _LightColor0;

		
			//float4 texture = tex2D(_MainTex, _MainTex_ST.xy * input.Texture.xy + _MainTex_ST.zw);
		
			//input struct
			struct inputStruct
			{
				float4 vertexPos : POSITION;
				float4 textureCoord : TEXCOORD0;
				//ADDING TO STEP 3
				float3 vertexNormal : NORMAL;
			};
			
			//output struct
			struct outputStruct
			{
				float4 pixelPos : SV_POSITION;
				float4 tex : TEXCOORD0;
				//ADDING TO STEP 3
				float4 colour : Color;
			};
			
			//vertex program
			outputStruct vertexFunction(inputStruct input)
			{
				outputStruct toReturn;
				float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
				float attenuation = 1.0;
				float3 ambientLight = UNITY_LIGHTMODEL_AMBIENT.rgb;
				
				float3 tempNorm = input.vertexNormal;
				float4 objNorm = mul(float4(tempNorm, 1.0), _World2Object);
				float3 normalizedNorm = normalize(objNorm).xyz;
				
				float3 normalDirection = normalize(mul(float4(input.vertexNormal, 1.0), _World2Object).xyz);
				float3 diffuseReflection = attenuation * _LightColor0.xyz * _Color.rgb * max(0.0, dot(normalizedNorm, lightDirection));
				
				float3 finalLight = diffuseReflection + ambientLight;
				toReturn.colour = float4(finalLight, 1.0);
				
				toReturn.pixelPos = mul(UNITY_MATRIX_MVP, input.vertexPos);
				toReturn.tex = input.textureCoord;
				return toReturn;
			}
			
			//fragment program
			float4 fragmentFunction(outputStruct input) : COLOR
			{
				//STEP 2: FLIP TILING AND OFFSET
				float4 tex = tex2D(_MainTex, _MainTex_ST.zw * input.tex.xy + _MainTex_ST.xy);
				//final bit of Step 3
				tex = tex * input.colour;
				
				return tex ;
			}
		
			ENDCG
			}
	} 
	FallBack "Diffuse"
}
