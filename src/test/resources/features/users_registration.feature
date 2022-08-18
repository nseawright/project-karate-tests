Feature: Validar o cadastro de usuários

  Background: Preparar dados para os testes
    # função para geração de uuid randômico
    * def uuid = function(){ return java.util.UUID.randomUUID() + '' }
    # variável payload, que recebe o payload base
    * string payload = read('classpath:data/users_payload.json')
    # variável createUser, com o caminho da feature comum que será chamada no teste para criação do usuário
    * def createUser = 'classpath:commons/create_user.feature'

  Scenario: Cadastrar novo usuário com sucesso
    # variável userCode, que recebe um uuid gerado randomicamente
    * def userCode = uuid()
    # variável userPayload, que recebe o payload base para manipularmos
    * string userPayload = payload

    # manipulação do payload, alterando os valores com o comando replace
    # o campo user_code (<userCode>) do userPayload, recebe o valor da variável userCode
    # o campo profile (<profile>) do userPayload, recebe o valor fixo 'GOLD'
    * replace userPayload
     | token     | value    |
     | userCode  | userCode |
     | profile   | 'GOLD'   |

    # chamada da feature "create_user" passando o userPayload (já manipulado).
    # O response será guardado na variável userResponse
    * def userResponse = call read(createUser) {userPayload: '#(userPayload)'}

    # validação do statusCode e das informações retornadas no response
    Then match userResponse.responseStatus == 201
      And match userResponse.response.id == '#notnull'
      And match userResponse.response.user_code == userCode
      And match userResponse.response.user_name == 'Daniel LaRusso'
      And match userResponse.response.born_date == '01/01/1980'
      And match userResponse.response.profile == 'GOLD'

  Scenario Outline: Cadastrar usuário sem enviar o campo obrigatório <campo>
    # variável userCode, que recebe um uuid gerado randomicamente
    * def userCode = uuid()
    # variável userPayload, que recebe o payload base para manipularmos
    * string userPayload = payload

    # manipulação do payload, alterando os valores com o comando replace
    # o campo user_code (<userCode>) do userPayload, recebe o valor da variável userCode
    # o campo profile (<profile>) do userPayload, recebe o valor fixo 'GOLD'
    * replace userPayload
      | token     | value    |
      | userCode  | userCode |
      | profile   | 'GOLD'   |

    # removendo do payload o campo conforme tabela de exemplos
    * remove userPayload.<campo>

    # chamada da feature "create_user" passando o userPayload (já manipulado).
    # O response será guardado na variável userResponse
    * def userResponse = call read(createUser) {userPayload: '#(userPayload)'}

    # validação do statusCode e das informações retornadas no response
    Then match userResponse.responseStatus == 400
    And match userResponse.response.error == '<campo> is required.'

    # será executado 1 (um) teste para cada exemplo listado
    Examples:
    | campo     |
    | user_code |
    | user_name |
    | born_date |








