class DropboxLinkValidator < ActiveModel::Validator
    def validate(record)
            unless record.pic.match("dl=0") || record.pic == ""
                record.errors[:pic] << "Image link invalid. Link must be a dropbox image link. Try the 'Share with Dropbox link'."
            end
    end
end