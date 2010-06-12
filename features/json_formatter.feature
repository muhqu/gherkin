Feature: JSON formatter
  In order to support greater access to features
  we want JSON

  Background:
    Given a JSON formatter
    And a "ruby" "root" parser

  Scenario: Only a Feature
    Given the following text is parsed:
      """
      Feature: OH HAI
      """
    Then the outputted JSON should be:
      """
      {
          "keyword": "Feature",
          "name": "OH HAI",
          "elements": []
      }
      """

  Scenario: Feature with two scenarios
    Given the following text is parsed:
      """
      @one
      Feature: OH HAI

        Scenario: Fujin
          Given wind
          Then spirit

        @two
        Scenario: _why
          Given chunky
          Then bacon

        @three @four
        Scenario Outline: Life
          Given some <boredom>
          
          @five
          Examples: Real life
            |boredom|
            |airport|
            |meeting|

        Scenario: who stole my mojo?
          When I was
            |asleep|
          And so
            \"\"\"
            innocent
            \"\"\"
      """
    Then the outputted JSON should be:
      """
      {
        "keyword": "Feature",
        "name": "OH HAI",
        "elements":[
          {
            "keyword": "Scenario",
            "name": "Fujin",
            "line": 4,
            "steps": [
              {
                "keyword": "Given ",
                "name": "wind",
                "line": 5
              },
              {
                "keyword": "Then ",
                "name": "spirit",
                "line": 6
              }
            ]
          },
          {
            "keyword": "Scenario",
            "name": "_why",
            "line": 9,
            "steps": [
              {
                "keyword": "Given ",
                "name": "chunky",
                "line": 10
              },
              {
                "keyword": "Then ",
                "name": "bacon",
                "line": 11
              }
            ]
          },
          {
            "keyword": "Scenario Outline",
            "name": "Life",
            "line": 14,
            "steps": [
              {
                "keyword": "Given ",
                "name": "some <boredom>",
                "line": 15
              }
            ]
          },
          {
            "keyword": "Examples",
            "name": "Real life",
            "line": 18,
            "table": [
              ["boredom"], 
              ["airport"], 
              ["meeting"]
            ]
          },
          {
            "keyword": "Scenario",
            "name": "who stole my mojo?",
            "line": 23,
            "steps": [
              {
                "keyword": "When ",
                "name": "I was",
                "line": 24,
                "table": [
                  [
                    "asleep"
                  ]
                ]
              },
              {
                "keyword": "And ",
                "name": "so",
                "line": 26,
                "py_string": "innocent"
              }
            ]
          }
        ]
      }
      """
