Shader "SimpleShader"
{
	Properties
	{
		//Actual name of property, Name that user will see in inspector, Type = Default Value
		_Color ("Flibberty Ghibbet", Color) = (0.0,0.0,0.0,1.0)
	}
	
	Subshader
	{
		Pass
		{
			CGPROGRAM //Auf Deutsche, bitte!
			//Pragmas
			#pragma vertex vertexFunction
			#pragma fragment fragmentFunction
			
			//User Defined Variables
			uniform float4 _Color;
			
			//Structs for passing data
			struct vertexInput
			{
				float4 vertexPosition : POSITION;
			};
			
			struct vertexOutput
			{
				float4 vertexPosition : SV_POSITION;
			};
			//Vertex function
			vertexOutput vertexFunction(vertexInput input)
			{
				vertexOutput output;
				output.vertexPosition = mul(UNITY_MATRIX_MVP, input.vertexPosition);
				
				return output;
			};
			//Fragment function
			float4 fragmentFunction(vertexOutput input) : COLOR
			{
				return _Color;
			};
			
			ENDCG
		}
	}
	
	//Fallback
	//Fallback "Diffuse"
}