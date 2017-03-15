def to_csv($headers):
    def _object_to_csv:
        ($headers | @csv),
        (.[] | [.[$headers[]]] | @csv);
    def _array_to_csv:
        ($headers | @csv),
        (.[][:$headers|length] | @csv);
    if .[0]|type == "object"
        then _object_to_csv
        else _array_to_csv
    end;
to_csv(["email", "lastname", "firstname", "company", "twitter"])
