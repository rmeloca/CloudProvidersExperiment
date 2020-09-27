package com.gabriel.web;

import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.gabriel.db.Observation;
import com.gabriel.db.ObservationDAO;

@Path("/record")
public class RecordData {

	@POST
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	@Produces(MediaType.TEXT_HTML)
	public String create(
			@FormParam("platform") String platform,
			@FormParam("api") String api,
			@FormParam("language") String language,
			@FormParam("activity") String activity,
			@FormParam("filesize") String filesize,
			@FormParam("latency") String latency,
			@FormParam("memory") String memory,
			@FormParam("cputime") String cputime)	{
		
		Observation o = new Observation();
		o.setPlatform(platform);
		o.setApi(api);
		o.setLanguage(language);
		o.setActivity(activity);
		o.setFilesize(new Integer(filesize));
		o.setLatency(new Double(latency));
		o.setMemory(new Double(memory));
		o.setCputime(new Double(cputime));
		
		ObservationDAO dao = new ObservationDAO();
		dao.create(o);
		
		return "ok";
	}
}
