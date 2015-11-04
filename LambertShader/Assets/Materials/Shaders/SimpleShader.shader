Shader "SimpleShader"
{
	Properties
	{
		//Actual name of property, Name that the user will see in the inspector. Type = Default Value
		_Color ("Flibberty Ghibbet", Color) = (0.0,0.0,0.0,1.0)
	}
	
	SubShader
	{
		Pass
		{
			CGPROGRAM
			//Pragmas
			#pragma vertex vertexFunction
			#pragma fragment fragmentFunction
			
			//User Defined Var
			uniform float4 _Color;
			
			//float, float2, float3, float4
			//half, half2, half3, half4
			//fixed, fixed2, fixed3, fixed4
			
			//structs
			struct vertexInput
			{
				float4 vertexPosition : POSITION; //Model relative? //float4 vertexPos = semantic;
			};
			
			//SEMANTICS
				//COLOR = the color of the vertex (float4)
				//POSITION - the position of the vertex
				//SV_POSITION - output position of vertex, dx11, output ONLY (float4)
				//NORMAL - normal of the vertex (float4)
				//TANGENT - tangent direction (float4)
				//TEXCOORD0 - the first UV map (float4)
				//TEXCOORD1 - the second UV map (float4)
				//TEXCOORD2 - ?? - Empty semantics for data transfer
				
			
			struct vertexOutput
			{
				float4 position : SV_POSITION;
			};
			
			//Vertex function
			vertexOutput vertexFunction( vertexInput input)
			{
				vertexOutput output;
				
				//REQUIRED FOR ALL VERTEX FUNCTINOS
				output.position = mul(UNITY_MATRIX_MVP, input.vertexPosition);
				
				//UNITY_MATRIX_MVP is a float4x4
				//Multiply each float4 of the matrix by the x,y,z of vertex position
					//float 4x4 myMatrix
					//myMatri[0] = UNITY_MATRIX_MVP[0] = input.vertexPosition.vertex
				return output;
			}
			
			//Fragment Function, aka pixel shader
			float4 fragmentFunction( vertexOutput input ) : COLOR
			{
				return _Color;
			}
			
			
			ENDCG
		}
	}
	//Fallback
	
	//Fallback "Diffuse"
}