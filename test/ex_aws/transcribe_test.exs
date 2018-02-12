defmodule ExAws.CognitoIdentityTest do
  use ExUnit.Case
  alias ExAws.Transcribe

  test "get_transcription_job" do
    assert Transcribe.get_transcription_job("ab140d8a-1002-44c0-80ab-16036f844e21").data == %{
      "TranscriptionJobName" => "ab140d8a-1002-44c0-80ab-16036f844e21"
    }
  end

  test "start_transcription_job" do
    assert Transcribe.start_transcription_job("en-US", "https://us-east-1.amazonaws.com/media-bucket/media-key", "mp3", "ab140d8a-1002-44c0-80ab-16036f844e21").data == %{
      "LanguageCode" => "en-US",
      "Media" => %{
        "MediaFileUri" => "https://us-east-1.amazonaws.com/media-bucket/media-key",
      },
      "MediaFormat" => "mp3",
      "TranscriptionJobName" => "ab140d8a-1002-44c0-80ab-16036f844e21"
    }
  end
end
