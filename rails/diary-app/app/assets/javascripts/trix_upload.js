Trix.config.attachments.preview.caption = {
  name: false,
  size: false
}

Trix.config.attachments.file.caption = {
  size: false
}

function uploadAttachment(attachment) {
  var file = attachment.file;
  var form = new FormData;
  form.append('Content-Type', file.type);
  form.append('photo[image]', file);

  var xhr = new XMLHttpRequest;
  xhr.open('POST', '/photos.json', true);
  xhr.setRequestHeader('X-CSRF-Token', Rails.csrfToken());

  xhr.upload.onprogress = function(e) {
    var progress = e.loaded / e.total * 100;
    attachment.setUploadProgress(progress);
  }

  xhr.onload = function() {
    if(xhr.status === 201) {
      var data = JSON.parse(xhr.responseText);
      return attachment.setAttributes({
        url: data.image_url,
        href: data.image_url
      })
    }
  }

  return xhr.send(form);
}

document.addEventListener('trix-attachment-add', function(e) {
  var attachment = e.attachment;
  if(attachment.file) {
    uploadAttachment(attachment);
  }
});

document.addEventListener('trix-attachment-remove', function(e) {
  var attachment = e.attachment;
  console.log(attachment);
});

document.addEventListener('trix-initialize', function(e) {
  console.log('init trix editor');
  var buttonHTML, fileInputHTML;
  buttonHTML = "<button type=\"button\" class=\"attach\" data-trix-action=\"x-attach\">Attach Files</button>";
  fileInputHTML = "<input type=\"file\" multiple>";
  $(Trix.config.toolbar.content).find(".button_group.block_tools").append(buttonHTML);
});

document.addEventListener('turbolinks:load', function (e) {
  console.log('editor change detected');
  var images = document.getElementsByTagName('img')
  for (img of images) {
    img.removeAttribute('height');
    img.removeAttribute('width');
  }
});
