function prependContent(newContent){
    // adds new content HTML to the beginning of the content section
    document.getElementById('content').innerHTML = newContent + document.getElementById('content').innerHTML;
}

function updateResources(newHTML){
    // replaces resource bar HTML with fresh, updated code. 
    document.getElementById("resource-bar").innerHTML = newHTML;
}

function cleanPlayerObjectRequest(objectStr) {
    // clean string related to player object requests
    var str = objectStr.replace(/([\:\,\'\{\}\(\)])+/g, "");
    str = str.replace(/(UUID)+/g, "");
    str = str.replace(/([\(\)])+/g, "");
    var split = str.split(" ");

    return split;
}

function parseObjectRemoval(str) {
    var split = cleanPlayerObjectRequest(str);
    // result result objectId uuid reason unknown
    var result, objectId, reason;
    for (var i = 0; i < split.length; i++) {
        var s = split[i];
        var next = i+1;
        if (s == 'result') {
            result = split[next];
        }
        else if (s == 'objectId') {
            objectId = split[next];
        }
        else if (s == 'reason') {
            reason = split[next];
        }
    }

    // check
    if ((result == undefined) || (objectId == undefined) || (reason == undefined)) {
        console.log("ERROR parsing object removal request. Player object not removed");
        return {result: false, objectId: objectId, reason: 'Removal request parsing failed.'};
    }

    return {result: result, objectId: objectId, reason: reason};
}

function parsePlayerObject(objectStr) {
    //{'owner': ownerName, 'objectId': uuid.uuid4(), 'type': objectType, 'model': model, 'data': data}
    // clean string and parse everything but data. NOTE: Data should be the last item in the dict
    var split = cleanPlayerObjectRequest(objectStr);
    var owner, objectId, type, model, orbitData;
    for (var ii = 0; ii < split.length; ii++) {
        var s = split[ii];
        var next = ii+1;
        if (s == 'owner') {
            owner = split[next];
        }
        else if (s == 'objectId') {
            objectId = split[next];
        }
        else if (s == 'type') {
            type = split[next];
        }
        else if (s == 'model') {
            model = split[next];
        }
        else if (s == 'orbit') {
            orbitData = split.slice(next, next+22);
        }
    }

    // info check
    if ((owner == undefined) || (objectId == undefined) || (type == undefined)
                             || (model == undefined) || (orbitData == undefined)) {
        console.log("ERROR parsing player object data returned from server. objectId: " + objectId);
        console.log("owner " + owner + " type " + type + " model " + model + " orbit " + orbitData);
        return null;
    }

    // parse orbit
    var ma, epoch, a, e, i, w_bar, w, L, om, P, full_name;
    for (var q = 0; q < orbitData.length; q++) {
        var stri = orbitData[q];
        var n = q+1;
        if (stri == 'ma') {
            ma = orbitData[n];
        }
        else if (stri == 'epoch') {
            epoch = orbitData[n];
        }
        else if (stri == 'a') {
            a = orbitData[n];
        }
        else if (stri == 'e') {
            e = orbitData[n];
        }
        else if (stri == 'i') {
            i = orbitData[n];
        }
        else if (stri == 'w_bar') {
            w_bar = orbitData[n];
        }
        else if (stri == 'w') {
            w = orbitData[n];
        }
        else if (stri == 'L') {
            L = orbitData[n];
        }
        else if (stri == 'om') {
            om = orbitData[n];
        }
        else if (stri == 'P') {
            P = orbitData[n];
        }
        else if (stri == 'full_name') {
            full_name = orbitData[n];
        }
    }

    // data check
    if ((P == undefined) || (e == undefined) || (full_name == undefined)
            || (ma == undefined) || (a == undefined) || (i == undefined) || (w_bar == undefined)
            || (w == undefined) || (L == undefined) || (om == undefined)
            || (P == undefined)) {
        console.log("ERROR parsing player object data returned from server. objectId: " + objectId);
        console.log("a " + a + " om " + om + " full_name " + full_name + " i " + i + " L " + L + " P " + P +
                    " epoch " + epoch + " w " + w + " w_bar " + w_bar + " ma " + ma);
        return null;
    }

    full_name = full_name.replace(/(\")+/g, "");

    var ephemeris = {full_name: full_name, ma: ma, epoch: epoch, a: a, e: e,
                        i: i, w_bar: w_bar, w: w, L: L, om: om, P: P};

    var orbit = new Orbit3D(ephemeris,
        {
            color: 0xff0000, width: 1, jed: rSimulate.jed, object_size: 1.7,
            display_color: new THREE.Color(0xff0000),
            particle_geometry: particle_system_geometry,
            name: full_name
        }, !using_webgl);

    return {owner: owner, objectId: objectId, type: type, model: model, orbit: orbit};
}

function parseMessage(m) {
    // interprets and carries out messages

    var cmd = m.split('"')[3];  // this should be right so long as "cmd" is listed first...
    var data = m.split(',"data":"')[1].slice(0, -2); // this assumes "data" is listed last

    if (cmd == "addToContent") {
        prependContent(data)

    } else if (cmd == "updateResources") {
        updateResources(data)

    } else if (cmd == "researchCompleted") {
        // try sending update to techtree (only works if techtree is displayed)
        techtree.completeResearch(data);
        // TODO: add user notification?

    } else if (cmd == "pObjCreate") {
        var object = parsePlayerObject(data);
        if (object != null) {
            object.orbit.name = object.orbit.name.replace(/([\"])+/g, " ").trim();
            console.log(object.orbit.name);
            var path = getPathForModel(object.model.toLocaleLowerCase());
            if (path != null) {
                rSimulate.addBlenderPlayerObjectMesh(path, object.orbit, object.objectId);
            }
            else {console.log("Could not find model path for object " + object.objectId)}
        }
        else {console.log("Parsing failed for unknown object")}

    } else if (cmd == "pObjRequest") {
        // TODO: display template

    } else if (cmd == "pObjDestroyRequest") {
        var request = parseObjectRemoval(data);
        if (request.result == 'True') {
            removeBody(undefined, "playerObject", request.objectId);
        }
        else {
            console.log("Destroy request for object " + request.objectId + " was denied because: " + request.reason);
        }
    } else {
        console.log("ERR: unknown message to client: "+m);
    }
}