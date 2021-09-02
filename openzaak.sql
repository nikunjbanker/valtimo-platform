EFCore:
    Scaffold-DbContext "Server=.\SQLExpress;Database=ProcessType;Trusted_Connection=True;" Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

INSERT INTO accounts_user (password, first_name, last_name, username, is_superuser, email, is_staff, is_active, date_joined) VALUES
('pbkdf2_sha256$150000$5dnJUqLDsmX0$EEbO4AGZqyp88ZCTu+7W2uGRLkdidlL4HkXWc8ZfZV8=', 'Valtimo', 'Demo', 'demo', true, 'demo@valtimo.nl', true, true, now());

INSERT INTO catalogi_catalogus (_admin_name, uuid, domein, rsin, contactpersoon_beheer_naam, contactpersoon_beheer_telefoonnummer, contactpersoon_beheer_emailadres) VALUES
('valtimo', '8225508a-6840-413e-acc9-6422af120db1', 'VAL', '002564440', 'Valtimo Demo', '06-12345678', 'demo@valtimo.nl');

INSERT INTO authorizations_applicatie (uuid, client_ids, label, heeft_alle_autorisaties) VALUES
(uuid_generate_v4(), '{valtimo_client}', 'Valtimo', true);

INSERT INTO vng_api_common_jwtsecret (identifier, secret) VALUES
('valtimo_client', 'e09b8bc5-5831-4618-ab28-41411304309d');

INSERT INTO catalogi_zaaktype (id, datum_begin_geldigheid, datum_einde_geldigheid, concept, uuid, identificatie, zaaktype_omschrijving, zaaktype_omschrijving_generiek, vertrouwelijkheidaanduiding, doel, aanleiding, toelichting, indicatie_intern_of_extern, handeling_initiator, onderwerp, handeling_behandelaar, doorlooptijd_behandeling, servicenorm_behandeling, opschorting_en_aanhouding_mogelijk, verlenging_mogelijk, verlengingstermijn, trefwoorden, publicatie_indicatie, publicatietekst, verantwoordingsrelatie, versiedatum, producten_of_diensten, selectielijst_procestype, referentieproces_naam, referentieproces_link, catalogus_id, selectielijst_procestype_jaar) VALUES (1, '2021-01-01', NULL, false, uuid_generate_v4(), 'bezwaar-behandelen', 'Bezwaar behandelen', 'Bezwaar behandelen', 'zaakvertrouwelijk', 'Een uitspraak doen op een ingekomen bezwaar tegen een eerder genomen besluit.', 'Er is een bezwaarschrift ontvangen tegen een besluit dat genomen is door de gemeente.', 'Conform de Algemene Wet Bestuursrecht (AWB) heeft een natuurlijk of niet-natuurlijk persoon de mogelijkheid om bezwaar te maken tegen een genomen besluit van de gemeente, bijvoorbeeld het niet verlenen van een vergunning.', 'extern', 'Indienen', 'Bezwaar', 'Behandelen', '84 days', NULL, false, true, '42 days', '{bezwaar,bezwaarschrift}', false, '', '{}', '2021-01-01', '{https://github.com/valtimo-platform/valtimo-platform}', 'https://selectielijst.openzaak.nl/api/v1/procestypen/e1b73b12-b2f6-4c4e-8929-94f84dd2a57d', 'Bezwaar behandelen', 'http://www.gemmaonline.nl/index.php/Referentieproces_bezwaar_behandelen', 1, 2017);

INSERT INTO catalogi_statustype (id, uuid, statustype_omschrijving, statustype_omschrijving_generiek, statustypevolgnummer, informeren, statustekst, toelichting, zaaktype_id) VALUES (2, uuid_generate_v4(), 'Intake afgerond', 'Intake afgerond', 1, true, 'Geachte heer/mevrouw, Op %ZAAK. Registratiedatum% heeft u een bezwaar ingediend. Uw bezwaar is bij ons in behandeling genomen onder zaaknummer %ZAAK. Zaakidentificatie%. Wij vragen u dit zaaknummer te gebruiken in geval van correspondentie over dit bezwaar cq. deze zaak.  U wordt per e-mail op de hoogte gehouden van de status van de behandeling van uw bezwaar.', 'Initiële status van de zaak waarbij het bezwaarschrift ontvangen is en naar aanleiding daarvan de zaak aangemaakt en de behandelaar bepaald is. De indiener is een ontvangstbevestiging van zijn (of haar) bezwaar gezonden.', 1);
INSERT INTO catalogi_statustype (id, uuid, statustype_omschrijving, statustype_omschrijving_generiek, statustypevolgnummer, informeren, statustekst, toelichting, zaaktype_id) VALUES (3, uuid_generate_v4(), 'Indieningsvereisten getoetst', 'Indieningsvereisten getoetst', 2, true, 'Geachte heer/mevrouw, Op %ZAAK.Registratiedatum% heeft u een bezwaar ingediend. Uw bezwaar is bij ons in behandeling onder zaaknummer %ZAAK.Zaakidentificatie% en is compleet bevonden. Dit houdt in dat wij uw bezwaar gaan beoordelen.  U wordt per e-mail op de hoogte gehouden van de status van de behandeling van uw bezwaar.', 'Het ingediende bezwaar is getoetst op de indieningsvereisten. De uitkomst van deze toets wordt vastgelegd in de eigenschap Uitslag toetsing. Indien er niet aan de indieningseisen wordt voldaan, dan wordt het bezwaar niet-ontvankelijk verklaard en kunnen de volgende vier statussen worden overgeslagen.', 1);
INSERT INTO catalogi_statustype (id, uuid, statustype_omschrijving, statustype_omschrijving_generiek, statustypevolgnummer, informeren, statustekst, toelichting, zaaktype_id) VALUES (4, uuid_generate_v4(), 'Bezwaar beoordeeld', 'Bezwaar beoordeeld', 3, true, 'Geachte heer/mevrouw, Op %ZAAK.Registratiedatum% heeft u een bezwaar ingediend. Uw bezwaar is bij ons in behandeling onder zaaknummer %ZAAK.Zaakidentificatie%. Wij hebben uw bezwaar beoordeeld en gaan nu de hoorzitting voorbereiden.  U wordt per e-mail op de hoogte gehouden van de status van de behandeling van uw bezwaar.', 'Het ingediende bezwaar is inhoudelijk beoordeeld. Indien gegrond dan is, indien mogelijk, het besluit herroepen of aangepast. Indien niet gegrond dan heeft, indien van toepassing, mediation plaatsgevonden. Indien het besluit als gegrond is beoordeeld of indien mediation heeft geleid tot overeenstemming, dan wordt de volgende status overgeslagen. In het andere geval wordt een statusmelding verzonden.', 1);
INSERT INTO catalogi_statustype (id, uuid, statustype_omschrijving, statustype_omschrijving_generiek, statustypevolgnummer, informeren, statustekst, toelichting, zaaktype_id) VALUES (5, uuid_generate_v4(), 'Hoorzitting gehouden', 'Hoorzitting gehouden', 4, false, '', 'Er is een verweerschrift opgesteld en verstuurd, een pleitnota is opgesteld en er heeft een hoorzitting plaatsgevonden. De bezwarencommissie heeft een advies uitgebracht.', 1);
INSERT INTO catalogi_statustype (id, uuid, statustype_omschrijving, statustype_omschrijving_generiek, statustypevolgnummer, informeren, statustekst, toelichting, zaaktype_id) VALUES (6, uuid_generate_v4(), 'Concept-besluit opgesteld', 'Concept-besluit opgesteld', 5, false, '', 'Het conceptbesluit voor de beslisser is opgesteld, indien van toepassing op basis van het advies van de bezwarencommissie.', 1);
INSERT INTO catalogi_statustype (id, uuid, statustype_omschrijving, statustype_omschrijving_generiek, statustypevolgnummer, informeren, statustekst, toelichting, zaaktype_id) VALUES (7, uuid_generate_v4(), 'Besluit vastgesteld', 'Besluit vastgesteld', 6, true, 'Geachte heer/mevrouw, Op %ZAAK.Registratiedatum% hebben wij heeft u een bezwaar ingediend. Uw bezwaar is bij ons in behandeling onder zaaknummer %ZAAK.Zaakidentificatie%.  De gemeente heeft een besluit genomen over uw bezwaar onder besluitnummer %BESLUIT. Besluitidentificatie%.  Het besluit van de gemeente is:  %BESLUIT.Toelichting%  Het schriftelijke besluit op uw bezwaar inclusief motivatie wordt zo spoedig mogelijk per post naar u toegestuurd.', 'De uitspraak op het bezwaar is vastgesteld door de beslisser.', 1);
INSERT INTO catalogi_statustype (id, uuid, statustype_omschrijving, statustype_omschrijving_generiek, statustypevolgnummer, informeren, statustekst, toelichting, zaaktype_id) VALUES (8, uuid_generate_v4(), 'Zaak afgerond', 'Zaak afgerond', 7, true, 'Geachte heer/mevrouw, Op %ZAAK. Registratiedatum% heeft u een bezwaar ingediend. Uw bezwaar is bij ons in behandeling onder zaaknummer %ZAAK.Zaakidentificatie%. Onlangs bent u al op de hoogte gesteld van het besluit. Met deze e-mail willen wij u mededelen dat het besluit per post naar u is toegestuurd en dat wij de zaak hebben afgesloten.', 'Het besluit is schriftelijk kenbaar gemaakt aan de indiener van het bezwaar. De zaak is gearchiveerd en afgehandeld.', 1);

INSERT INTO catalogi_eigenschapspecificatie(id, groep, formaat, lengte, kardinaliteit, waardenverzameling) VALUES (1, 'tekst', 'tekst', 100, 1, '{}');

INSERT INTO catalogi_eigenschap(id, toelichting, uuid, eigenschapnaam, definitie, specificatie_van_eigenschap_id, zaaktype_id) VALUES (1, '', uuid_generate_v4(), 'voornaam', 'voornaam', 1, 1);
INSERT INTO catalogi_eigenschap(id, toelichting, uuid, eigenschapnaam, definitie, specificatie_van_eigenschap_id, zaaktype_id) VALUES (2, '', uuid_generate_v4(), 'achternaam', 'achternaam', 1, 1);
INSERT INTO catalogi_eigenschap(id, toelichting, uuid, eigenschapnaam, definitie, specificatie_van_eigenschap_id, zaaktype_id) VALUES (3, '', uuid_generate_v4(), 'bsn', 'bsn', 1, 1);
INSERT INTO catalogi_eigenschap(id, toelichting, uuid, eigenschapnaam, definitie, specificatie_van_eigenschap_id, zaaktype_id) VALUES (4, '', uuid_generate_v4(), 'bezwaar', 'bezwaar', 1, 1);
INSERT INTO catalogi_eigenschap(id, toelichting, uuid, eigenschapnaam, definitie, specificatie_van_eigenschap_id, zaaktype_id) VALUES (5, '', uuid_generate_v4(), 'straatnaam', 'straatnaam', 1, 1);
INSERT INTO catalogi_eigenschap(id, toelichting, uuid, eigenschapnaam, definitie, specificatie_van_eigenschap_id, zaaktype_id) VALUES (6, '', uuid_generate_v4(), 'huisnummer', 'huisnummer', 1, 1);
INSERT INTO catalogi_eigenschap(id, toelichting, uuid, eigenschapnaam, definitie, specificatie_van_eigenschap_id, zaaktype_id) VALUES (7, '', uuid_generate_v4(), 'toevoeging', 'toevoeging', 1, 1);
INSERT INTO catalogi_eigenschap(id, toelichting, uuid, eigenschapnaam, definitie, specificatie_van_eigenschap_id, zaaktype_id) VALUES (8, '', uuid_generate_v4(), 'postcode', 'postcode', 1, 1);
INSERT INTO catalogi_eigenschap(id, toelichting, uuid, eigenschapnaam, definitie, specificatie_van_eigenschap_id, zaaktype_id) VALUES (9, '', uuid_generate_v4(), 'plaats', 'plaats', 1, 1);
INSERT INTO catalogi_eigenschap(id, toelichting, uuid, eigenschapnaam, definitie, specificatie_van_eigenschap_id, zaaktype_id) VALUES (10, '', uuid_generate_v4(), 'telefoonnummer', 'telefoonnummer', 1, 1);
INSERT INTO catalogi_eigenschap(id, toelichting, uuid, eigenschapnaam, definitie, specificatie_van_eigenschap_id, zaaktype_id) VALUES (11, '', uuid_generate_v4(), 'e-mailadres', 'e-mailadres', 1, 1);
INSERT INTO catalogi_eigenschap(id, toelichting, uuid, eigenschapnaam, definitie, specificatie_van_eigenschap_id, zaaktype_id) VALUES (12, '', uuid_generate_v4(), 'zaaknummer', 'zaaknummer', 1, 1);
INSERT INTO catalogi_eigenschap(id, toelichting, uuid, eigenschapnaam, definitie, specificatie_van_eigenschap_id, zaaktype_id) VALUES (13, '', uuid_generate_v4(), 'datumBesluit', 'datumBesluit', 1, 1);
INSERT INTO catalogi_eigenschap(id, toelichting, uuid, eigenschapnaam, definitie, specificatie_van_eigenschap_id, zaaktype_id) VALUES (14, '', uuid_generate_v4(), 'besluit', 'besluit', 1, 1);
INSERT INTO catalogi_eigenschap(id, toelichting, uuid, eigenschapnaam, definitie, specificatie_van_eigenschap_id, zaaktype_id) VALUES (15, '', uuid_generate_v4(), 'communicatie', 'communicatie', 1, 1);
INSERT INTO catalogi_eigenschap(id, toelichting, uuid, eigenschapnaam, definitie, specificatie_van_eigenschap_id, zaaktype_id) VALUES (16, '', uuid_generate_v4(), 'beslissingBezwaar', 'beslissingBezwaar', 1, 1);
INSERT INTO catalogi_eigenschap(id, toelichting, uuid, eigenschapnaam, definitie, specificatie_van_eigenschap_id, zaaktype_id) VALUES (17, '', uuid_generate_v4(), 'naamBehandelaar', 'naamBehandelaar', 1, 1);
INSERT INTO catalogi_eigenschap(id, toelichting, uuid, eigenschapnaam, definitie, specificatie_van_eigenschap_id, zaaktype_id) VALUES (18, '', uuid_generate_v4(), 'e-mailBehandelaar', 'e-mailBehandelaar', 1, 1);
INSERT INTO catalogi_eigenschap(id, toelichting, uuid, eigenschapnaam, definitie, specificatie_van_eigenschap_id, zaaktype_id) VALUES (19, '', uuid_generate_v4(), 'aanvraagAanvulInfo', 'aanvraagAanvulInfo', 1, 1);
INSERT INTO catalogi_eigenschap(id, toelichting, uuid, eigenschapnaam, definitie, specificatie_van_eigenschap_id, zaaktype_id) VALUES (20, '', uuid_generate_v4(), 'aanvullendeInfo', 'aanvullendeInfo', 1, 1);
INSERT INTO catalogi_eigenschap(id, toelichting, uuid, eigenschapnaam, definitie, specificatie_van_eigenschap_id, zaaktype_id) VALUES (21, '', uuid_generate_v4(), 'naamBeslisser', 'naamBeslisser', 1, 1);