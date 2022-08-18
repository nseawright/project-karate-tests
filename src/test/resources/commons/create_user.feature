@ignore
Feature: Cadastro de usuários

  Scenario: Criar usuário
    Given url ApiUrl
      And path 'users'
      And header Content-Type = 'application/json; charset=utf-8'
      And header X-API-Key = XApiKey
      And request userPayload
    When method POST
