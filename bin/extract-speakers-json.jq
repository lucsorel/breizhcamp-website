def lowercase:
    if .|type == "string" then
        . | explode | map( if 65 <= . and . <= 90 then . + 32  else . end) | implode
    else
        ""
    end;


def filter_object_data:
    . | { id: .id,
            lastname: .lastname, firstname: .firstname,
            imageProfilURL: .imageProfilURL, bio: .bio,
            github: .github, googleplus: .googleplus, twitter: .twitter,
            social: .social
        };


def remove_duplicate:
    # je supprime les doublons (nom, prénom), en gardant celui qui a la plus longue bio
    . | sort_by (.bio | length) | reverse | unique_by ((.lastname | lowercase), (.firstname | lowercase));


def remove_if_empty_name:
    if ((.lastname | length) == 0) and ((.firstname | length) == 0) then
        empty
    else
        .
    end;


def final_sort:
    . | sort_by ((.lastname | lowercase), (.firstname | lowercase));


[ .[] | filter_object_data ] | remove_duplicate | map(remove_if_empty_name) | final_sort
