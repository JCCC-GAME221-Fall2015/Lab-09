Shader "Lambert_Dark"
{
	Properties //Interface between shaders and unity/the inspector
	{
		//Name ("Display name", Type) = Default()
		_Color ("Color",Color) = (1.0,1.0,1.0,1.0)
	}
	SubShader //Start of our shader
	{
		Pass //Layering effects
		{
			CGPROGRAM
			#pragma vertex vertexFunction
			#pragma fragment fragmentFunction
			
			//user defined variables
			uniform float4 _Color;
			
			//Unity Defined Variables
			uniform float3 _LightColor0;
			
			
			//structs
			struct vertexInput
			{
				float4 vertexPos : POSITION;
				float3 vertexNormal : NORMAL;
			};
			struct vertexOutput
			{
				float4 position : SV_POSITION;
				float4 colour : COLOR;
			};
			
			//vertex function
			vertexOutput vertexFunction(vertexInput input)
			{
				vertexOutput output;
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
				
				//float4(float3, alpha) how to cast in a shader
				
								//x,y,z,w
								//or
								//r,g,b,a
								//new float4 with xyzw
								//float(x,y,z,w)
								//overload
								//float(xyz, w)
				output.colour = float4(finalLight, 1.0);
				
				output.position = mul(UNITY_MATRIX_MVP, input.vertexPos);
				return output;
			}
						
			//fragment function
			float4 fragmentFunction(vertexOutput input) : COLOR
			{
				return input.colour;
			}
			
			ENDCG
		}
	}
	//fallback
}