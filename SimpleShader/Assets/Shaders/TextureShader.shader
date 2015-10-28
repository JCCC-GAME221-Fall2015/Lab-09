Shader "TextureShader"
{
	Properties
	{
		// Actual name of the property (name that the user will see in the inspector, Type) = Default Value
		_Color("Color Tint", Color) = (1.0, 1.0, 1.0, 1.0)
		_MainText("Diffuse Texture", 2D) = "white" {}
	}

	Subshader
	{
		Pass
		{
			CGPROGRAM

			// Pragmas
			#pragma vertex vertexFunction
			#pragma fragment fragmentFunction

			// User defined var
			uniform float4 _Color;
			uniform sampler2D _MainText;
			uniform float4 _MainText_ST;

			// Structs for passing data
			struct vertexInput
			{
				float4 vertexPosition : POSITION;		// Get the vertex position
				float4 textureCoord : TEXCOORD0;		

			};

			struct vertexOutput
			{
				float4 position : SV_POSITION;			// Output the vertex position
				float4 tex : TEXCOORD0;
			};


			// Vertex function
			vertexOutput vertexFunction(vertexInput input)
			{
				vertexOutput returnVertex;

				returnVertex.position = mul(UNITY_MATRIX_MVP, input.vertexPosition);

				returnVertex.tex = input.textureCoord;
		
				return returnVertex;
			}

			// Fragment function aka pixel shader
			float4 fragmentFunction(vertexOutput output) : COLOR
			{
				float4 tex = tex2D(_MainText, _MainText_ST.xy * output.tex.xy + _MainText_ST.zw);

				return float4(tex.rgb,1.0);
			}

			ENDCG
		}
	}

		// Fallback
		//Fallback "Diffuse"
}