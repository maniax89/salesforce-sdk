/**
 * Language Translator translates text from one language to another. The service offers multiple domain-specific models
 * that you can customize based on your unique terminology and language. Use Language Translator to take news from
 * across the globe and present it in your language, communicate with your customers in their own language, and more.
 *
 * @version V2
 * @see <a href="http://www.ibm.com/watson/developercloud/language-translator.html">Language Translator</a>
 */
public class IBMLanguageTranslatorV2 extends IBMWatsonService {

  private static final String URL = 'https://gateway.watsonplatform.net/language-translator/api';
  private String versionDate;

  /**
   * Instantiates a new `IBMLanguageTranslatorV2`.
   *
   */
  public IBMLanguageTranslatorV2() {
    super('watson_language_translator_v2');
  }

  /**
   * Instantiates a new `IBMLanguageTranslatorV2` with username and password.
   *
   * @param username the username
   * @param password the password
   */
  public IBMLanguageTranslatorV2(String username, String password) {
    this();
    setUsernameAndPassword(username, password);
  }

  /**
   * Translates the input text from the source language to the target language.
   *
   * @param translateOptions the {@link IBMLanguageTranslatorV2Models.TranslateOptions} containing the options for the call
   * @return the {@link IBMLanguageTranslatorV2Models.TranslationResult} with the response
   */
  public IBMLanguageTranslatorV2Models.TranslationResult translate(IBMLanguageTranslatorV2Models.TranslateOptions translateOptions) {
    IBMWatsonValidator.notNull(translateOptions, 'translateOptions cannot be null');
    IBMWatsonRequestBuilder builder = IBMWatsonRequestBuilder.httpPost(getEndPoint() + '/v2/translate');
    final Map<String, Object> contentJson = new Map<String, Object>();
    contentJson.put('text', translateOptions.text());
    if (translateOptions.modelId() != null) {
      contentJson.put('model_id', translateOptions.modelId());
    }
    if (translateOptions.source() != null) {
      contentJson.put('source', translateOptions.source());
    }
    if (translateOptions.target() != null) {
      contentJson.put('target', translateOptions.target());
    }
    builder.bodyJson(JSON.serialize(contentJson, true));

    return (IBMLanguageTranslatorV2Models.TranslationResult) createServiceCall(builder.build(), IBMLanguageTranslatorV2Models.TranslationResult.class);
  }

  /**
   * Identifies the language of the input text.
   *
   * @param identifyOptions the {@link IBMLanguageTranslatorV2Models.IdentifyOptions} containing the options for the call
   * @return the {@link IBMLanguageTranslatorV2Models.IdentifiedLanguages} with the response
   */
  public IBMLanguageTranslatorV2Models.IdentifiedLanguages identify(IBMLanguageTranslatorV2Models.IdentifyOptions identifyOptions) {
    IBMWatsonValidator.notNull(identifyOptions, 'identifyOptions cannot be null');
    IBMWatsonRequestBuilder builder = IBMWatsonRequestBuilder.httpPost(getEndPoint() + '/v2/identify');
    builder.bodyContent(identifyOptions.text(),'text/plain');

    return (IBMLanguageTranslatorV2Models.IdentifiedLanguages) createServiceCall(builder.build(), IBMLanguageTranslatorV2Models.IdentifiedLanguages.class);
  }

  /**
   * Lists all languages that can be identified by the API.
   *
   * Lists all languages that the service can identify. Returns the two-letter code (for example, `en` for English or `es` for Spanish) and name of each language.
   *
   * @param listIdentifiableLanguagesOptions the {@link IBMLanguageTranslatorV2Models.ListIdentifiableLanguagesOptions} containing the options for the call
   * @return the {@link IBMLanguageTranslatorV2Models.IdentifiableLanguages} with the response
   */
  public IBMLanguageTranslatorV2Models.IdentifiableLanguages listIdentifiableLanguages(IBMLanguageTranslatorV2Models.ListIdentifiableLanguagesOptions listIdentifiableLanguagesOptions) {
    IBMWatsonRequestBuilder builder = IBMWatsonRequestBuilder.httpGet(getEndPoint() + '/v2/identifiable_languages');

    return (IBMLanguageTranslatorV2Models.IdentifiableLanguages) createServiceCall(builder.build(), IBMLanguageTranslatorV2Models.IdentifiableLanguages.class);
  }

  /**
   * Uploads a TMX glossary file on top of a domain to customize a translation model.
   *
   * @param createModelOptions the {@link IBMLanguageTranslatorV2Models.CreateModelOptions} containing the options for the call
   * @return the {@link IBMLanguageTranslatorV2Models.TranslationModel} with the response
   */
  public IBMLanguageTranslatorV2Models.TranslationModel createModel(IBMLanguageTranslatorV2Models.CreateModelOptions createModelOptions) {
    IBMWatsonValidator.notNull(createModelOptions, 'createModelOptions cannot be null');
    IBMWatsonValidator.isTrue((createModelOptions.forcedGlossary() != null) || (createModelOptions.parallelCorpus() != null) || (createModelOptions.monolingualCorpus() != null), 'At least one of forced_glossary, parallel_corpus, or monolingual_corpus must be supplied.');
    IBMWatsonRequestBuilder builder = IBMWatsonRequestBuilder.httpPost(getEndPoint() + '/v2/models');
    if (createModelOptions.baseModelId() != null) {
      builder.query('base_model_id', createModelOptions.baseModelId());
    }
    if (createModelOptions.name() != null) {
      builder.query('name', createModelOptions.name());
    }
    IBMWatsonMultipartBody.Builder multipartBuilder = new IBMWatsonMultipartBody.Builder();
    multipartBuilder.setType(IBMWatsonMultipartBody.FORM);
    if (createModelOptions.forcedGlossary() != null) {
      IBMWatsonRequestBody fileBody = IBMWatsonRequestBody.create(createModelOptions.forcedGlossary(), createModelOptions.forcedGlossaryContentType());
      multipartBuilder.addFormDataPart('forced_glossary', createModelOptions.forcedGlossaryFilename(), fileBody);
    }
    if (createModelOptions.parallelCorpus() != null) {
      IBMWatsonRequestBody fileBody = IBMWatsonRequestBody.create(createModelOptions.parallelCorpus(), createModelOptions.parallelCorpusContentType());
      multipartBuilder.addFormDataPart('parallel_corpus', createModelOptions.parallelCorpusFilename(), fileBody);
    }
    if (createModelOptions.monolingualCorpus() != null) {
      IBMWatsonRequestBody fileBody = IBMWatsonRequestBody.create(createModelOptions.monolingualCorpus(), createModelOptions.monolingualCorpusContentType());
      multipartBuilder.addFormDataPart('monolingual_corpus', createModelOptions.monolingualCorpusFilename(), fileBody);
    }
    IBMWatsonMultipartBody multipartBody = multipartBuilder.build();
    builder.body(multipartBody).addHeaders(multipartBody.getAllHeaders());

    return (IBMLanguageTranslatorV2Models.TranslationModel) createServiceCall(builder.build(), IBMLanguageTranslatorV2Models.TranslationModel.class);
  }

  /**
   * Deletes a custom translation model.
   *
   * @param deleteModelOptions the {@link IBMLanguageTranslatorV2Models.DeleteModelOptions} containing the options for the call
   * @return the service call
   */
  public void deleteModel(IBMLanguageTranslatorV2Models.DeleteModelOptions deleteModelOptions) {
    IBMWatsonValidator.notNull(deleteModelOptions, 'deleteModelOptions cannot be null');
    IBMWatsonRequestBuilder builder = IBMWatsonRequestBuilder.httpDelete(getEndPoint() + String.format('/v2/models/{0}', new String[]{ deleteModelOptions.modelId() }));

    createServiceCall(builder.build(), null);
  }

  /**
   * Get information about the given translation model, including training status.
   *
   * @param getModelOptions the {@link IBMLanguageTranslatorV2Models.GetModelOptions} containing the options for the call
   * @return the {@link IBMLanguageTranslatorV2Models.TranslationModel} with the response
   */
  public IBMLanguageTranslatorV2Models.TranslationModel getModel(IBMLanguageTranslatorV2Models.GetModelOptions getModelOptions) {
    IBMWatsonValidator.notNull(getModelOptions, 'getModelOptions cannot be null');
    IBMWatsonRequestBuilder builder = IBMWatsonRequestBuilder.httpGet(getEndPoint() + String.format('/v2/models/{0}', new String[]{ getModelOptions.modelId() }));

    return (IBMLanguageTranslatorV2Models.TranslationModel) createServiceCall(builder.build(), IBMLanguageTranslatorV2Models.TranslationModel.class);
  }

  /**
   * Lists available standard and custom models by source or target language.
   *
   * @param listModelsOptions the {@link IBMLanguageTranslatorV2Models.ListModelsOptions} containing the options for the call
   * @return the {@link IBMLanguageTranslatorV2Models.TranslationModels} with the response
   */
  public IBMLanguageTranslatorV2Models.TranslationModels listModels(IBMLanguageTranslatorV2Models.ListModelsOptions listModelsOptions) {
    IBMWatsonRequestBuilder builder = IBMWatsonRequestBuilder.httpGet(getEndPoint() + '/v2/models');
    if (listModelsOptions != null && listModelsOptions.source() != null) {
      builder.query('source', listModelsOptions.source());
    }
    if (listModelsOptions != null && listModelsOptions.target() != null) {
      builder.query('target', listModelsOptions.target());
    }
    if (listModelsOptions != null && listModelsOptions.defaultField() != null) {
      builder.query('default', String.valueOf(listModelsOptions.defaultField()));
    }

    return (IBMLanguageTranslatorV2Models.TranslationModels) createServiceCall(builder.build(), IBMLanguageTranslatorV2Models.TranslationModels.class);
  }

}
