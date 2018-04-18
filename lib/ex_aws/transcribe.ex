defmodule ExAws.Transcribe do
  import ExAws.Utils, only: [camelize_keys: 2]

  @namespace "Transcribe"

  def get_transcription_job(transcription_job_name, opts \\ []) do
    data = opts
    |> normalize_opts
    |> Map.merge(%{"TranscriptionJobName" => transcription_job_name})

    request(:get_transcription_job, data)
  end

  def start_transcription_job(language_code, media_file_uri, media_format, transcription_job_name, opts \\ []) do
    data = opts
    |> normalize_opts
    |> Map.merge(%{
      "LanguageCode" => language_code,
      "Media" => %{
        "MediaFileUri" => media_file_uri
      },
      "MediaFormat" => media_format,
      "TranscriptionJobName" => transcription_job_name,
    })

    request(:start_transcription_job, data)
  end

  defp normalize_opts(opts) do
    opts
    |> Map.new
    |> camelize_keys(deep: true)
  end

  defp request(action, data, opts \\ []) do
   operation = action
   |> Atom.to_string
   |> Macro.camelize

    ExAws.Operation.JSON.new(:transcribe, %{
      data: data,
      headers: [
        {"x-amz-target", "#{@namespace}.#{operation}"},
        {"content-type", "application/x-amz-json-1.1"},
      ],
      http_method: opts[:http_method] || :post
    })
  end
end
