# Olympedia

Este projeto processa diversos dados históricos de diversas edições dos Jogos Olímpicos, gerando como resultado uma modelagem apropriada para uma análise profunda dos dados. 

## Fonte dos Dados

A Olympedia é um portal que fornece diversos dados históricos sobre os Jogos Olímpicos, desde atletas participantes, passando por jogos e seus resultados, até informações sobre as cerimônias de abertura.

Sua criação se origina do esforço de diversos historiadores e estatísticos, que ao longo de vários anos, compilaram todos os dados disponibilizados na plataforma, construindo o que se acredita ser a maior e mais precisa base de dados sobre Jogos Olímpicos já existente.

Além de disponíveis no próprio site da Olympedia, as suas informações também podem ser encontrados em outros portais de dados, que geralmente os extraem e aplicam um processamento e limpeza prévios, tornando-os mais acessíveis para uma gama maior de usuários. Especificamente neste projeto, os dados utilizados foram extraídos da Base dos Dados, plataforma brasileira e sem fins lucrativos, que fornece um extenso portfólio de dados tratados aos seus usuários para diversos fins de utilização.

Como os dados da plataforma são disponibilizados publicamente via BigQuery, que coincidentemente também é a plataforma de processamento utilizada por este projeto, a ingestão dos dados de origem se resume a uma simples consulta, o que facilita bastante a execução deste projeto.

## Arquitetura

O projeto foi estruturado seguindo uma versão customizada da Arquitetura de Medalhão com 4 camadas, descritas abaixo.

### Bronze 

Na camada Bronze, os dados foram mantidos em formato muito similar ao encontrado na sua fonte original. A organização original de tabelas foi mantida, e apenas dois tipos de operações de processamento foram realizadas:
- Conversão de Colunas para tipos de dados adequados.
- Renomeação de colunas visando padronização. 

### Silver

Na camada Silver, os dados foram submetidos a um processamento mais conceitual, onde a organização original de tabelas foi reestruturada visando uma estrutura mais simples e lógica do ponto de vista dos seus possíveis usuários finais. Com isso, as seguintes tabelas foram estruturadas:
- silver_olympedia__athlete: Tabela contendo informações sobre todos os atletas competidores dos Jogos Olímpicos, como nome, gênero, peso e altura e sua nacionalidade.
- silver_olympedia__country: Listagem dos países participantes dos Jogos Olímpicos e sua sigla utilizada pelo Comitê Olímpico.
- silver_olympedia__edition: Tabela contendo informações sobre as diversas edições dos Jogos Olímpicos, como o seu local de realização, calendário de início e fim e quadro final de medalhas.
- silver_olympedia__event: Tabela listando os eventos realizados durante os Jogos Olímpicos, relacionando os esportes e suas modalidades.
- silver_olympedia__result: Tabela listando os todos os resultados das olímpiadas, que consiste no posicionamento de um determinado atleta em um determinado evento de uma determinada edição.

### Gold

Na camada Gold, os dados estruturados na Silver foram modelados em Star Schema para uma apresentação eficiente para seus usuários. Como resultado, as seguintes tabelas foram geradas:
- gold_olympedia__dim_athlete: Tabela dimensão contendo informações dos atletas.
- gold_olympedia__dim_edition: Tabela dimensão contendo informações das edições.
- gold_olympedia__dim_event: Tabela dimensão contendo uma listagem dos eventos.
- gold_olympedia__fact_result: Tabela fato, relacionando atletas, edições e eventos em torno de um resultado competitivo.

### Obt 

A camada de Obt é uma camada adicional e complementar à camada Gold visando apresentar os dados aos usuários para consumos em formatos agregados pré-calculados relevantes ou de dados que não tenham sido abordados no Star Schema. A partir desta ideia, as seguintes tabelas agreagdas foram geradas:
- obt_olympedia__athlete_medals: Agregado de medalhas conquistadas por cada atleta competidor.
- obt_olympedia__country_medals: Agregado de medalhas conquistadas por cada delegação participante.
- obt_olympedia__editions: Tabela contendo informações agregadas sobre cada edição, como quantidade de eventos ocorridos, total de atletas participantes e medalhas distribuídas.
- obt_olympedia__events: Agregado de medalhas conquistadas por cada delegação participante detalhado por esporte e modalidade.

## Documentação e Testes

Utilizando as funcionalidades disponíveis pelo DBT, uma documentação foi gerada para todas as camadas deste projeto, contendo descrições informativas para cada tabela e cada um de seus campos.

Além disso, para as camadas Bronze, Silver e Gold, diversos testes foram adicionados, principalmente relacionados a checagem de unicidade de campos de identificação ou combinação de campos. 