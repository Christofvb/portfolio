exp = Experience.first

# ── EXPERIENCE ───────────────────────────────────────────────────────────────

Mobility.with_locale(:en) do
  exp.job_title = "Fullstack Web Developer"
  exp.missions  = <<~HTML
    <ul>
      <li>Technical maintenance and support across multiple internal applications</li>
      <li>Development of new features</li>
      <li>Writing technical documentation</li>
      <li>Collaboration in Agile methodology (sprints, Jira tickets)</li>
    </ul>
  HTML
  exp.tools = <<~HTML
    <ul>
      <li>Ruby, JavaScript (jQuery / AJAX), SQL, HTML, SCSS</li>
      <li>Framework: Ruby on Rails</li>
      <li>Tools: Git, Bitbucket, RubyMine, GraphQL, XML, REST API, HMAC, OAuth, Postman, Ngrok, Jira, Confluence, Docker, RSpec</li>
    </ul>
  HTML
  exp.save
end

Mobility.with_locale(:nl) do
  exp.job_title = "Fullstack Webontwikkelaar"
  exp.missions  = <<~HTML
    <ul>
      <li>Technisch onderhoud en support voor meerdere interne applicaties</li>
      <li>Ontwikkeling van nieuwe functionaliteiten</li>
      <li>Schrijven van technische documentatie</li>
      <li>Samenwerking via Agile-methode (sprints, Jira-tickets)</li>
    </ul>
  HTML
  exp.tools = <<~HTML
    <ul>
      <li>Ruby, JavaScript (jQuery / AJAX), SQL, HTML, SCSS</li>
      <li>Framework: Ruby on Rails</li>
      <li>Tools: Git, Bitbucket, RubyMine, GraphQL, XML, REST API, HMAC, OAuth, Postman, Ngrok, Jira, Confluence, Docker, RSpec</li>
    </ul>
  HTML
  exp.save
end

puts "Experience translated"

# ── PROJECTS ─────────────────────────────────────────────────────────────────

translations = {
  "Gestion de la facturation partenaires" => {
    en: {
      name: "Partner Billing Management",
      description: "<p>Integration of partner billing into the MOOC (Massive Open Online Course) management application.</p>"
    },
    nl: {
      name: "Beheer partnerfacturatie",
      description: "<p>Integratie van partnerfacturatie in de MOOC-beheertoepassing (Massive Open Online Course).</p>"
    }
  },
  "FAQ interactive et personnalisée" => {
    en: {
      name: "Interactive & Personalised FAQ",
      description: "<p>Development of a personalised video FAQ module. Each user sees videos tailored to their learning path, with dynamically calculated dates to support their progression in the application.</p>"
    },
    nl: {
      name: "Interactieve & gepersonaliseerde FAQ",
      description: "<p>Ontwikkeling van een gepersonaliseerde video-FAQ-module. Elke gebruiker ziet video's afgestemd op zijn parcours, met dynamisch berekende datums om zijn voortgang in de applicatie te ondersteunen.</p>"
    }
  },
  "Amélioration du temps de chargement des candidatures" => {
    en: {
      name: "Application Loading Time Improvement",
      description: "<p>Reduced the loading time of application pages through Benchmark analysis and SQL query optimisation, improving user experience and application responsiveness.</p>"
    },
    nl: {
      name: "Verbetering laadtijd sollicitaties",
      description: "<p>Verkorting van de laadtijd van sollicitatiepagina's via Benchmark-analyse en SQL-queryoptimalisatie, met verbetering van de gebruikerservaring en reactiesnelheid van de applicatie.</p>"
    }
  },
  "Module de QCM Certifiants" => {
    en: {
      name: "Certified MCQ Module",
      description: "<p>Implementation of a module allowing users to create certified multiple-choice quizzes tailored to students based on their training programme. Questions are dynamically generated in the form using JavaScript and Ruby, with tracking of attempt counts and results via an interactive dashboard.</p>"
    },
    nl: {
      name: "Gecertificeerde meerkeuzevragenmodule",
      description: "<p>Implementatie van een module waarmee gebruikers gecertificeerde meerkeuzevragen kunnen aanmaken, afgestemd op studenten op basis van hun opleiding. Vragen worden dynamisch gegenereerd via JavaScript en Ruby, met bijhouding van pogingen en resultaten via een interactief dashboard.</p>"
    }
  },
  "Module de génération automatisée de courriers LRAR" => {
    en: {
      name: "Automated LRAR Letter Generation Module",
      description: "<p>Implementation of a dynamic module for managing registered letters with acknowledgement of receipt (LRAR). The user selects the letter type (formal warning, reprimand, etc.) and can customise the document accordingly. The module automatically generates a ready-to-download PDF, processed in the background using DelayedJob.</p>"
    },
    nl: {
      name: "Geautomatiseerde LRAR-brievengenerator",
      description: "<p>Implementatie van een dynamische module voor het beheer van aangetekende brieven met ontvangstbevestiging (LRAR). De gebruiker selecteert het type brief en past het document aan. De module genereert automatisch een downloadklare PDF, verwerkt op de achtergrond via DelayedJob.</p>"
    }
  },
  "Intégration Indeed Apply & Data Sync" => {
    en: {
      name: "Indeed Apply Integration & Data Sync",
      description: "<p>Development of a full integration module with Indeed Apply. The workflow includes XML feed generation with Indeed Apply tags and Screener Questions, secure receipt of application data (HMAC verification), mapping and processing of information to match internal parameters, and synchronisation of application statuses via GraphQL with OAuth.</p>"
    },
    nl: {
      name: "Indeed Apply-integratie & datasynchronisatie",
      description: "<p>Ontwikkeling van een volledige integratiemodule met Indeed Apply. De workflow omvat XML-feedgeneratie met Indeed Apply-tags en Screener Questions, beveiligde ontvangst van sollicitatiegegevens (HMAC-verificatie), mapping van informatie naar interne parameters, en synchronisatie van sollicitatiestatussen via GraphQL met OAuth.</p>"
    }
  },
  "API Convergence – Gestion des dossiers Cerfa" => {
    en: {
      name: "Convergence API – Cerfa File Management",
      description: "<p>Maintenance and improvement of the Convergence API dedicated to managing Cerfa administrative files. Work carried out: performance optimisation, bug fixes and functional improvements to enhance the reliability and efficiency of administrative file processing.</p>"
    },
    nl: {
      name: "Convergence API – Cerfa-dossiers",
      description: "<p>Onderhoud en verbetering van de Convergence API voor het beheer van Cerfa-dossiers. Uitgevoerd werk: prestatieoptimalisatie, bugfixes en functionele uitbreidingen om de betrouwbaarheid en efficiëntie van de verwerking van administratieve dossiers te verbeteren.</p>"
    }
  }
}

Project.find_each do |project|
  fr_name = project.read_attribute(:name)
  data    = translations[fr_name]
  next puts "No translation found for: #{fr_name}" unless data

  [:en, :nl].each do |locale|
    Mobility.with_locale(locale) do
      project.name        = data[locale][:name]
      project.description = data[locale][:description]
      project.save
    end
  end
  puts "  ✓ #{fr_name}"
end

puts "\nDone — all translations seeded."
